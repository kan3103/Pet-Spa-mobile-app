from django.urls import path
from . import views
urlpatterns = [
    path('pet/register/', views.PetCreateView.as_view(), name='pet-create'),
    path('pet/list/<str:status>/', views.PetListView.as_view(), name='pet-list'),
    path('pet/<str:name>/', views.PetDetailView.as_view(), name='pet-detail'),
    path('staffs/', views.StaffListView.as_view(), name='staff-list'),
    path('', views.ProfileView.as_view(), name='profile'),
]