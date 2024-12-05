from django.urls import path
from . import views

urlpatterns = [
  path('services/', views.ServiceOrderListView.as_view(), name='order-list'),
  path('services/<int:order_id>', views.ServiceOrderDetailView.as_view(), name='order-detail'),
  path('products/', views.ProductOrderListView.as_view(), name='product-order-list'),
  path('services/all', views.ServiceOrderViewManager.as_view()),
]