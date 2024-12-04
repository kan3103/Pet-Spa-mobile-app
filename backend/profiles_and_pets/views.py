from django.forms import ValidationError
from rest_framework import generics,status
from rest_framework.permissions import AllowAny,IsAuthenticated
from .models import Pet
from auths.models import Customer
from .serializers import PetSerializer,ProfileSerializer

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
        try:
            customer = Customer.objects.get(id=self.request.user.id)
        except Customer.DoesNotExist:
            raise ValidationError({"detail": "The user is not a registered customer."})
        return Pet.objects.filter(owner=customer)
    
    
    
    
class ProfileView(generics.RetrieveUpdateAPIView):
    queryset = Customer.objects.all()
    serializer_class = ProfileSerializer
    permission_classes = [IsAuthenticated]
    def get_object(self):
        return self.request.user