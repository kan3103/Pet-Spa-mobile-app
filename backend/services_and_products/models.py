from django.db import models
from rest_framework.permissions import  IsAuthenticated

# class RoleBasedPermission(BasePermission):
#     allowed_read = ['staff']
#     allowed_write = ['manager']

#     def has_permission(self, request, view):
#         if request.method == SAFE_METHODS:
#             return request.user.role in self.allowed_read
#         if request.method in ['POST', 'PUT', 'DELETE']:
#             return request.user.role in self.allowed_write

# Create your models here.
class Service(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)
    price = models.IntegerField()
    description = models.TextField()

    class Meta:
        verbose_name = 'Service'
        verbose_name_plural = 'Services'
        db_table = 'services'
        

    def __str__(self):
        return self.name
    

class Product(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)
    price = models.IntegerField()
    total_stock = models.IntegerField()

    class Meta:
        verbose_name = 'Product'
        verbose_name_plural = 'Products'
        db_table = 'products'

    def __str__(self):
        return self.name
    
# class ServiceDetails(models.Model):
#     class Status(models.IntegerChoices):
#         Pending = 1, 'Pending'
#         Processing = 2, 'In progress'
#         Done = 3, 'Done'
#     id = models.AutoField(primary_key=True)
#     pet = models.ForeignKey('profiles_and_pets.Pet', on_delete=models.CASCADE)
#     staff = models.ForeignKey('auths.Staff', on_delete=models.CASCADE)
#     service = models.ForeignKey(Service, on_delete=models.CASCADE)
#     status = models.IntegerField(choices=Status.choices)

#     class Meta:
#         verbose_name = 'Service Detail'
#         verbose_name_plural = 'Service Details'
#         db_table = 'service_details'
#         constraints = [
#             models.UniqueConstraint(
#                 fields=['pet', 'service'],
#                 name='unique_pet_service'
#             ),
#         ]
