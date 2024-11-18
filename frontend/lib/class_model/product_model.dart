import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final List<String> images;
  final double price;
  final List<String> categories;

  Product({
    required this.name,
    required this.description,
    required this.images,
    required this.price,
    required this.categories,
  });
}