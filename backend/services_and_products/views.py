from django.http import JsonResponse
import json
from django.views import View
from .models import Service
from utils.decorators import validate_jwt, permission_required
from django.conf import settings

class ServiceListCreateView(View):
    @validate_jwt
    def get(self, request):
        services = list(Service.objects.all().values())
        for service in services:
            service['image'] = f"{settings.HOSTNAME}/media/" + service['image']
        return JsonResponse(services  , safe=False, status=200)
    
    @validate_jwt
    @permission_required(['manager'])
    def post(self, request):
        data = json.loads(request.body.replace(b'\n',b''))
        service = None
        if not request.FILES.get('image'):
            service = Service.objects.create(
                name=data.get('name'),
                price=data.get('price'),
                description=data.get('description')
            )
        else:
            service = Service.objects.create(
                name=data.get('name'),
                price=data.get('price'),
                image=request.FILES.get('image'),
                description=data.get('description')
            )
        if not service:
            return JsonResponse({'error': 'Service not created'}, status=400)
        return JsonResponse({'service': service.id}, status=201)


class ServiceDetailView(View):
    @validate_jwt
    def get(self, request, **kwargs):
        try:
            service = Service.objects.get(id=kwargs.get('pk'))
            return JsonResponse({'id': service.id, 'name': service.name, 'price': service.price, 'image': f"{settings.HOSTNAME}/media/" + service.image.name, 'description': service.description})
        except Service.DoesNotExist:
            return JsonResponse({'error': 'Service not found'}, status=404)