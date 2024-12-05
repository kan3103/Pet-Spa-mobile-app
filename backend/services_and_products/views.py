from rest_framework import generics
from .models import Product, Service
from .serializers import ProductSerializer, ServiceSerializer

# Product Views
class ProductListCreateView(generics.ListCreateAPIView):
  queryset = Product.objects.all()
  serializer_class = ProductSerializer

class ProductRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
  queryset = Product.objects.all()
  serializer_class = ProductSerializer

# Service Views
class ServiceListCreateView(generics.ListCreateAPIView):
  queryset = Service.objects.all()
  serializer_class = ServiceSerializer

class ServiceRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
  queryset = Service.objects.all()
  serializer_class = ServiceSerializer
