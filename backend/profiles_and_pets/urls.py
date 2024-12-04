from django.urls import path
from . import views
urlpatterns = [
    path('pet/register/', views.PetCreateView.as_view(), name='pet-create'),
    path('pet/list/', views.PetListView.as_view(), name='pet-list'),
    path('', views.ProfileView.as_view(), name='profile'),
]