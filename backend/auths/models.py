from django.db import models
from django.contrib.auth.models import User

class MyUser(User):
    phone = models.CharField(max_length=11, blank=True, null=True)
    birthday = models.DateField(blank=True, null=True)

class Customer(User):
    number_pet = models.IntegerField(default=0)

class Staff(User):
    salary = models.FloatField(blank=True, null=True)



