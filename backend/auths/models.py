from django.db import models
from django.contrib.auth.models import User

class MyUser(User):
    phone = models.CharField(max_length=11, blank=True, null=True,default= None)
    birthday = models.DateField(blank=True, null=True, default=None)

class Customer(MyUser):
    number_pet = models.IntegerField(default=0,blank=True, null=True)

class Staff(MyUser):
    salary = models.FloatField(blank=True, null=True, default=None)



