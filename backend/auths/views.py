import requests
from rest_framework import generics,status
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
from .models import Customer,User
from .serializers import CusSerializer, TokenSerializer
from rest_framework_simplejwt.tokens import RefreshToken
# Create your views here.

class CreateUserView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = CusSerializer
    permission_classes = [AllowAny]

class GoogleLogin(generics.GenericAPIView):
    permission_classes = [AllowAny]
    serializer_class = TokenSerializer
    def get(self, request):
        access_token = request.GET.get('access_token')
        # Get Oauth 2.0 from google
        req = requests.get(f"https://www.googleapis.com/oauth2/v2/userinfo", headers={
            "Authorization": f"Bearer {access_token}"
        }).json()   
        
        # Check if customer already exists
        try:
            email = req['email']
            if User.objects.filter(email=email).exists():
                user = User.objects.get(email=email)
                refesh = RefreshToken.for_user(user)
                return Response({
                    "refresh": str(refesh),
                    "access": str(refesh.access_token),
                })
            else:
                return Response({
                    "email": req['email'],
                    "last_name": req['family_name'],
                    "first_name": req['given_name'],
                })
        except:
            return Response({"error": "Token not valid"})

    def post(self,request):
        access_token = request.GET.get('access_token')
        req = requests.get(f"https://www.googleapis.com/oauth2/v2/userinfo", headers={
            "Authorization": f"Bearer {access_token}"
        }).json()
        
        try:
            username = request.data.get('username')
            email = request.data.get('email')
            
            # Check the token and email are the same
            if req['email'] != email:
                return Response({"error": "Token not valid"})
            else:
                user = Customer.objects.create_user(username=username, email=email, last_name=req["family_name"], first_name=req["given_name"])
                refesh = RefreshToken.for_user(user)
                return Response({
                    "refresh": str(refesh),
                    "access": str(refesh.access_token),})
        except Exception as e:
            return Response(
                {f"error: Missing {str(e)}"}, 
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )


