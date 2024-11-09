from rest_framework.response import Response
from rest_framework import generics
from rest_framework.permissions import AllowAny
from .models import User
from .serializers import CusSerializer
# Create your views here.

class CreateUserView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = CusSerializer
    permission_classes = [AllowAny]

class GoogleLogin(generics.GenericAPIView):
    permission_classes = [AllowAny]
    
    def get(self,request):
        return Response({"message":"Google login"})