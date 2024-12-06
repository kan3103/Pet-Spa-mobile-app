from django.db import models
from rest_framework.permissions import  IsAuthenticated, BasePermission
from auths.views import IsManager

class IsManagerOrReadOnly(BasePermission):
    def has_permission(self, request, view):
        if request.method in ['GET', 'HEAD', 'OPTIONS']:
            return IsAuthenticated().has_permission(request, view)
        return IsManager().has_permission(request, view)

# Create your models here.
class Service(models.Model):
    # permission_classes = [IsManagerOrReadOnly]
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)
    price = models.IntegerField()
    image = models.ImageField(upload_to='services/', default='services/default.jpg')
    description = models.TextField()

    class Meta:
        verbose_name = 'Service'
        verbose_name_plural = 'Services'
        db_table = 'services'
        

    def __str__(self):
        return self.name
    

class Product(models.Model):
    # permission_classes = [IsManagerOrReadOnly]
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)
    price = models.IntegerField()
    image = models.ImageField(upload_to='products/', default='products/default.jpg')
    total_stock = models.IntegerField()

    class Meta:
        verbose_name = 'Product'
        verbose_name_plural = 'Products'
        db_table = 'products'

    def __str__(self):
        return self.name

