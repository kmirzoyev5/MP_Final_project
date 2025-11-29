import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [
    Product(id: '1', name: 'Latte', price: 4.50, imageUrl: '', category: 'Hot Coffee'),
    Product(id: '2', name: 'Iced Americano', price: 3.50, imageUrl: '', category: 'Cold Coffee'),
    Product(id: '3', name: 'Espresso', price: 3.00, imageUrl: '', category: 'Espresso'),
    Product(id: '4', name: 'Cappuccino', price: 4.00, imageUrl: '', category: 'Hot Coffee'),
  ];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    // Mimic network delay
    await Future.delayed(const Duration(milliseconds: 500));
    notifyListeners();
  }
}