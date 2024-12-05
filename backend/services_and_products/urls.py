from django.urls import path
from . import views

urlpatterns = [
  path('services/', views.ServiceListCreateView.as_view(), name='service-list'),
  path('services/<int:pk>/', views.ServiceRetrieveUpdateDestroyView.as_view(), name='service-detail'),
  path('products/', views.ProductListCreateView.as_view(), name='product-list'),
  path('products/<int:pk>/', views.ProductRetrieveUpdateDestroyView.as_view(), name='product-detail'),
]