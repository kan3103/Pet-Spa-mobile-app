import json
from django.forms import ValidationError
from django.http import HttpResponse, JsonResponse
from rest_framework import generics
from rest_framework.permissions import AllowAny,IsAuthenticated
from .models import Pet,Profile
from auths.models import Customer,MyUser, Staff
from django.views import View
from .serializers import PetSerializer,ProfileSerializer
from orders.models import ServiceOrder
class CustomJsonResponse(HttpResponse):
    def __init__(self, data, **kwargs):
        kwargs['content_type'] = 'application/json; charset=utf-8'
        super().__init__(content=json.dumps(data, ensure_ascii=False), **kwargs)
class PetCreateView(generics.ListCreateAPIView):
    queryset = Pet.objects.all()
    serializer_class = PetSerializer
    permission_classes = [IsAuthenticated]
    def perform_create(self, serializer):
        try:
            customer = Customer.objects.get(id=self.request.user.id)
        except Customer.DoesNotExist:
            raise ValidationError({"detail": "The user is not a registered customer."})
        
        serializer.save(owner=customer)
    
# pet list of customer
class PetListView(generics.ListAPIView):
    serializer_class = PetSerializer
    permission_classes = [AllowAny]
    def get_queryset(self):
        status = self.kwargs.get('status')
        try:
            customer = Customer.objects.get(id=self.request.user.id)
        except Customer.DoesNotExist:
            raise ValidationError({"detail": "The user is not a registered customer."})
        if status == 'all':
            return Pet.objects.filter(owner=customer)
        elif status == 'now':
            pet = Pet.objects.filter(owner=customer)
            a = []
            for p in pet:
                if not ServiceOrder.objects.filter(pet=p,status=1).exists():
                    a.append(p)
            return a
        return Pet.objects.filter(owner=customer)
    
class PetDetailView(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = PetSerializer
    permission_classes = [IsAuthenticated]
    def get_queryset(self):
        customer = Customer.objects.get(id=self.request.user.id)
        return Pet.objects.filter(owner=customer)
    def get_object(self):
        namePet = self.kwargs.get('name')
        customer = Customer.objects.get(id=self.request.user.id)
        pet = Pet.objects.get(name=namePet,owner=customer)
        return pet
        

  
class ProfileView(generics.RetrieveUpdateAPIView):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    permission_classes = [IsAuthenticated]
    
    def get_object(self):
        name = self.kwargs.get('name')
        if name == 'me':
            my = MyUser.objects.get(id=self.request.user.id)
            return Profile.objects.get(user = my)
        else:
            my = MyUser.objects.get(id = int(name))
            return Profile.objects.get(user = my)
    def get(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        data = serializer.data
        return CustomJsonResponse(data=data)

    def put(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)

        return CustomJsonResponse(data=serializer.data)
    

class StaffListView(View):
    def get(self, request):
        staffs = Staff.objects.all()
        data = []
        for staff in staffs:
            if staff.manager:
                continue
            staffuser = MyUser.objects.get(id=staff.id)
            profile = Profile.objects.get(user=staffuser)
            data.append({
                "id": staff.id,
                "username": staff.username,
                "email": staff.email,
                "image": profile.avatar.url if profile.avatar else None,
            })
        return JsonResponse(data, safe=False)
    
class CustomerListView(generics.ListAPIView):
    permission_classes = [IsAuthenticated]
    queryset = Customer.objects.all()
    def get(self, request):
        customers = Customer.objects.all()
        data = []
        
        for customer in customers:
            cususer = MyUser.objects.get(id=customer.id)
            profile = Profile.objects.get(user=cususer)
            data.append({
                "id": customer.id,
                "username": customer.username,
                "email": customer.email,
                # "image": profile.avatar.url if profile.avatar else None,
            })
        return CustomJsonResponse(data=data)
    
