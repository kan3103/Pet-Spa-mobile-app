from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
from functools import wraps
from auths.models import Customer, Staff
import jwt

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
            try:
                request.user = Customer.objects.get(id=request.user_id)
                request.role = 'customer'
            except Customer.DoesNotExist:
                request.user = Staff.objects.get(id=request.user_id)
                if request.user.manager:
                    request.role = 'manager'
                else:
                    request.role = 'staff'
            except:
                return JsonResponse({'error': 'User not found'}, status=404)
        except jwt.ExpiredSignatureError:
            return JsonResponse({'error': 'Token has expired'}, status=401)
        except jwt.InvalidTokenError:
            return JsonResponse({'error': 'Invalid token'}, status=401)
        
        
        # Call the wrapped function
        return func(self, request, *args, **kwargs)
    return wrapper

def permission_required(allowed_roles):
    def decorator(func):
        @wraps(func)
        def wrapper(self, request, *args, **kwargs):
            if request.role not in allowed_roles:
                return JsonResponse({'error': 'Permission denied'}, status=403)
            return func(self, request, *args, **kwargs)
        return wrapper
    return decorator