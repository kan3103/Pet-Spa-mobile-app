from django.urls import path
from . import views

urlpatterns = [
  path('services/', views.ServiceOrderListView.as_view(), name='order-list'),
  path('services/<int:order_id>/', views.ServiceOrderDetailView.as_view(), name='order-detail'),
  path('services/all/', views.ServiceOrderViewManager.as_view()),
  path('services/pay/', views.ServicesPaymentView.as_view()),
]