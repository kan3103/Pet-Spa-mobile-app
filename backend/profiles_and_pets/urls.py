from django.urls import path
from . import views
urlpatterns = [
    path('register/pet', views.PetCreateView.as_view(), name='pet-create'),
    path('list/pet', views.PetListView.as_view(), name='pet-list'),
]