import 'package:flutter/material.dart';
import 'package:frontend/class_model/product_model.dart';

class CartItem {
  final Product product; // Thông tin sản phẩm
  int quantity; // Số lượng sản phẩm trong giỏ hàng
  VoidCallback? onRemove; // Hàm callback khi giảm số lượng
  VoidCallback? onAdd; // Hàm callback khi tăng số lượng

  CartItem({
    required this.product,
    this.quantity = 1, // Mặc định số lượng là 1
    this.onRemove,
    this.onAdd,
  });
}