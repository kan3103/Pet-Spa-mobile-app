from django.urls import path
from rest_framework_simplejwt.views import  TokenRefreshView
from . import views
urlpatterns = [
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('login/', views.LoginView.as_view(), name='login'),
    path('register/', views.CreateUserView.as_view(), name='create_user'),
    path('google/', views.GoogleLogin.as_view(), name='google_login'),
    path('logout/', views.LogoutView.as_view(), name='logout'),
    path('register/staff/', views.CreateStaffView.as_view(), name='create_staff'),
]