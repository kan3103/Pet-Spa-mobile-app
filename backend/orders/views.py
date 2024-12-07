from django.http import JsonResponse
from django.views import View
from .models import ServiceOrder, ProductOrder
from profiles_and_pets.models import Pet
from services_and_products.models import Service, Product
from auths.models import Customer, Staff
from utils.decorators import validate_jwt, permission_required
from django.conf import settings
import json


class ServiceOrderListView(View):
  @validate_jwt
  def get(self, request):
    user = request.user
    orders = [{'id': order['id'], 'status': order['status'], 'pet': Pet.objects.get(id=order['pet_id']).name, 'service': Service.objects.get(id=order['service_id']).name} for order in list(ServiceOrder.objects.filter(user = user).values())]

    return_instance = {}
    for order in orders:
      if order['pet'] not in return_instance:
        return_instance[order['pet']] = {}
        return_instance[order['pet']]['orders'] = []
        return_instance[order['pet']]['type'] = Pet.objects.get(name=order['pet']).pet_type
      return_instance[order['pet']]['orders'].append(order)
    
    if request.GET.get('done'):
      return_instance = {k:v for k,v in return_instance.items() if any(order['status'] == 2 for order in v['orders'])}
    else:
      return_instance = {k:v for k,v in return_instance.items() if any(order['status'] == 1 for order in v['orders'])}

    return JsonResponse(return_instance, safe=False, status=200)
  
  @validate_jwt
  def post(self, request):
    try:
      pets = json.loads(request.body.replace(b'\n',b''))['pets']
      for pet in pets:
        for service in pet['services']:
          s = Service.objects.get(name=service)
          ServiceOrder.objects.create(
             user = Customer.objects.get(id=request.user_id), pet = Pet.objects.get(name=pet['name']), service = s)
        
    except json.JSONDecodeError:
      return JsonResponse({'error': 'Invalid JSON'}, status=400)
    return JsonResponse({'message': 'Order created successfully'}, status=201)
  

class ServiceOrderDetailView(View):
  @validate_jwt
  def get(self, request, order_id):
    try:
      order = ServiceOrder.objects.get(id=order_id)
      return JsonResponse({'id': order.id, 'status': order.status, 'pet': order.pet.name, 'service': order.service.name})
    except ServiceOrder.DoesNotExist:
      return JsonResponse({'error': 'Order not found'}, status=404)
    
  @validate_jwt
  @permission_required(['manager', 'staff'])
  def put(self, request, order_id):
    try:
      order = ServiceOrder.objects.get(id=order_id)
      data = json.loads(request.body.replace(b'\n',b''))
      print(data)
      if 'status' in data:
        order.status = data['status']
      if 'staff' in data:
        order.staff = Staff.objects.get(id=data['staff'])
      
      order.save()
      return JsonResponse({'message': 'Order updated successfully'})
    except ServiceOrder.DoesNotExist:
      return JsonResponse({'error': 'Order not found'}, status=404)
    except json.JSONDecodeError:
      return JsonResponse({'error': 'Invalid JSON'}, status=400)



class ProductOrderListView(View):
  @validate_jwt
  def get(self, request):
    user = Customer.objects.get(id = request.user_id)
    orders = list(ProductOrder.objects.filter(user = user).values())
    return JsonResponse(orders, safe=False)
  
  @validate_jwt
  def post(self, request):
    try:
      products = json.loads(request.body.replace(b'\n',b''))['products']
      for product in products:
        ProductOrder.objects.create(
          user = Customer.objects.get(id=request.user_id), 
          product = Product.objects.get(name=product['name']), 
          quantity = product['quantity'])
    except json.JSONDecodeError:
      return JsonResponse({'error': 'Invalid JSON'}, status=400)
    return JsonResponse({'message': 'Order created successfully'}, status=201)
  

class ServiceOrderViewManager(View):
    @validate_jwt
    # @permission_required(['manager'])
    def get(self, request):
      services = list(ServiceOrder.objects.values())
      return_instance = {}
      for order in services:
        usrname = Customer.objects.get(id=order['user_id']).username
        if usrname not in return_instance:
          return_instance[usrname] = []
        service = Service.objects.get(id=order['service_id'])
        return_instance[usrname].append({'id': order['id'], 'status': order['status'], 'pet': Pet.objects.get(id=order['pet_id']).name, 'service': service.name, 'service_img': settings.HOSTNAME + service.image.url})

      return JsonResponse(return_instance, safe=False)
  


