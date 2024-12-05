from django.db import models

class Order(models.Model):
    id = models.AutoField(primary_key=True)
    user = models.ForeignKey('auths.Customer', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        abstract = True


class ServiceOrder(Order):
    class Status(models.IntegerChoices):
        Pending = 1, 'Pending'
        Processing = 2, 'In progress'
        Done = 3, 'Done'
        Paid = 4, 'Paid'
    status = models.IntegerField(choices=Status.choices, default=Status.Pending)
    staff = models.ForeignKey('auths.Staff', on_delete=models.CASCADE, blank=True, null=True)
    pet = models.ForeignKey('profiles_and_pets.Pet', on_delete=models.CASCADE)
    service = models.ForeignKey('services_and_products.Service', on_delete=models.CASCADE)

    class Meta:
        verbose_name = 'Service Order'
        verbose_name_plural = 'Service Orders'
        db_table = 'service_orders'

class ProductOrder(Order):
    product = models.ForeignKey('services_and_products.Product', on_delete=models.CASCADE)
    quantity = models.IntegerField()
    class Meta:
        verbose_name = 'Product Order'
        verbose_name_plural = 'Product Orders'
        db_table = 'product_orders'