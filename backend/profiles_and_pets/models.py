from django.db import models
from django.contrib.auth.models import User
from auths.models import MyUser,Customer
# Create your models here.

class Pet(models.Model):
    class PetType(models.IntegerChoices):
        Dog = 1, 'Dog'
        Cat = 2, 'Cat'
        Rabbit = 3, 'Rabbit'
        Hamster = 4, 'Hamster'
    name = models.CharField(max_length=100)
    owner = models.ForeignKey(Customer, on_delete=models.CASCADE)
    dob = models.DateField(blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    image = models.ImageField(upload_to='pets/', blank=True, null=True)
    vaccinated = models.BooleanField(default=False)
    pet_type = models.IntegerField(choices=PetType.choices)
    
    
    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=['owner', 'name'],
                name='unique_pet_name'
            ),
        ]
    def __str__(self):
        return self.name

class Profile(models.Model):
    user = models.OneToOneField(MyUser, on_delete=models.CASCADE)
    birthday = models.DateField(blank=True, null=True)
    avatar = models.ImageField(upload_to='avatars/', blank=True, null=True)
    address = models.TextField(blank=True, null=True)
    
# class ProfileUser(Profile):
    