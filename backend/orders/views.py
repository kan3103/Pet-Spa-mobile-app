from django.http import JsonResponse
from django.views import View
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
from .models import ServiceOrder, ProductOrder
from profiles_and_pets.models import Pet
from services_and_products.models import Service, Product
from auths.models import Customer, Staff
from functools import wraps
import jwt
import json
def validate_jwt(func):
    @wraps(func)
    def wrapper(self, request, *args, **kwargs):
        # Extract token from the Authorization header
        token = request.headers.get('Authorization')
        if not token:
            return JsonResponse({'error': 'Authorization token missing'}, status=401)
        if not token.startswith('Bearer '):
            return JsonResponse({'error': 'Invalid token format'}, status=401)
        
        try:
            # Decode the token
            token = token[7:]  # Strip "Bearer " prefix
            decoded_token = jwt.decode(token, settings.SECRET_KEY, algorithms=['HS256'])
            request.user_id = decoded_token.get('user_id')
            if not request.user_id:
                return JsonResponse({'error': 'Invalid token payload'}, status=401)
        except jwt.ExpiredSignatureError:
            return JsonResponse({'error': 'Token has expired'}, status=401)
        except jwt.InvalidTokenError:
            return JsonResponse({'error': 'Invalid token'}, status=401)
        
        # Call the wrapped function
        return func(self, request, *args, **kwargs)
    return wrapper

class ServiceOrderListView(View):
  @validate_jwt
  def get(self, request):
    user = Customer.objects.get(id = request.user_id)
    orders = list(ServiceOrder.objects.filter(user = user).values())
    return JsonResponse(orders, safe=False)
  
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
  


