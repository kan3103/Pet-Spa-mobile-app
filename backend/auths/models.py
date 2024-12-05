from django.core.exceptions import ValidationError
from django.utils.timezone import now
from django.db import models
from django.contrib.auth.models import User


class MyUser(User):
    phone = models.CharField(max_length=11, blank=True, null=True, default=None)
    birthday = models.DateField(blank=True, null=True, default=None)

    def clean(self):
        super().clean()
        if self.phone and not self.phone.isdigit():
            raise ValidationError({"phone": "Phone number must contain only digits."})

        if self.birthday and self.birthday > now().date():
            raise ValidationError({"birthday": "Birthday cannot be in the future."})
    
    class Meta:
        constraints = [
            models.UniqueConstraint(fields=['phone'], name='unique_phone'),
        ]


class Customer(MyUser):
    number_pet = models.IntegerField(default=0, blank=True, null=True)

    def clean(self):
        super().clean()
        if self.number_pet is not None and self.number_pet < 0:
            raise ValidationError({"number_pet": "Number of pets cannot be negative."})
    class Meta:
        verbose_name = "Customer"
        verbose_name_plural = "Customers"

class Staff(MyUser):
    salary = models.FloatField(blank=True, null=True, default=None)
    manager  = models.BooleanField(default=False)

    class Meta:
        verbose_name = "Staff"
        verbose_name_plural = "Staff Members"
    def clean(self):
        super().clean()
        if self.salary is not None and self.salary <= 0:
            raise ValidationError({"salary": "Salary must be greater than 0."})



