import requests
from rest_framework import generics,status
from rest_framework.response import Response
from rest_framework.permissions import AllowAny,IsAuthenticated
from .models import Customer,User,Staff
from .serializers import CusSerializer, TokenSerializer ,StaffSerializer
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.permissions import BasePermission

class IsStaff(BasePermission):
    def has_permission(self, request, view):
        return request.user.is_authenticated  and request.user.is_staff
    
    
    
class CreateUserView(generics.CreateAPIView):
    queryset = Customer.objects.all()
    serializer_class = CusSerializer
    permission_classes = [AllowAny]

class CreateStaffView(generics.CreateAPIView):
    queryset = Staff.objects.all()
    serializer_class = StaffSerializer
    permission_classes = [IsAuthenticated,IsStaff]


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
                    "account": "customer",
                })
            else:
                return Response({
                    "email": req['email'],
                    "last_name": req['family_name'],
                    "first_name": req['given_name'],
                })
        except:
            return Response({"error": "Token not valid"}, status=status.HTTP_400_BAD_REQUEST)

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

class LogoutView(generics.GenericAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = TokenSerializer
    def post(self,request):
        refresh_token = request.data.get("refresh")
        token = RefreshToken(refresh_token)
        token.blacklist()  
        return Response({"message": "Logout sucessfully"}, status=200)

