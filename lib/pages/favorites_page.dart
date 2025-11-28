import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/favorites_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Product> allProducts = [
    Product(
      id: '1',
      name: 'Espresso',
      description: 'Rich and bold espresso shot with a perfect crema.',
      price: 3.99,
      imageUrl: 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?auto=format&fit=crop&w=800&q=80',
      category: 'Espresso',
    ),
    Product(
      id: '2',
      name: 'Cappuccino',
      description: 'Classic cappuccino with steamed milk and foam.',
      price: 4.99,
      imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?auto=format&fit=crop&w=800&q=80',
      category: 'Hot Coffee',
    ),
    Product(
      id: '3',
      name: 'Caffe Latte',
      description: 'Smooth espresso with steamed milk and light foam.',
      price: 4.99,
      imageUrl: 'https://images.unsplash.com/photo-1561882468-9110e03e0f78?auto=format&fit=crop&w=800&q=80',
      category: 'Hot Coffee',
    ),
    Product(
      id: '4',
      name: 'Americano',
      description: 'Espresso diluted with hot water for a smooth taste.',
      price: 3.49,
      imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?auto=format&fit=crop&w=800&q=80',
      category: 'Hot Coffee',
    ),
    Product(
      id: '5',
      name: 'Cold Brew',
      description: 'Smooth cold-steeped coffee served over ice.',
      price: 4.49,
      imageUrl: 'https://images.unsplash.com/photo-1517487881594-2787fef5ebf7?auto=format&fit=crop&w=800&q=80',
      category: 'Cold Coffee',
    ),
    Product(
      id: '6',
      name: 'Mocha',
      description: 'Espresso with chocolate, steamed milk, and whipped cream.',
      price: 5.49,
      imageUrl: 'https://images.unsplash.com/photo-1578314675249-a6910f80cc4e?auto=format&fit=crop&w=800&q=80',
      category: 'Specialty',
    ),
    Product(
      id: '7',
      name: 'Macchiato',
      description: 'Espresso marked with a dollop of foamed milk.',
      price: 4.29,
      imageUrl: 'https://images.unsplash.com/photo-1557006021-b85faa2bc5e2?auto=format&fit=crop&w=800&q=80',
      category: 'Espresso',
    ),
    Product(
      id: '8',
      name: 'Flat White',
      description: 'Velvety microfoam over a double shot of espresso.',
      price: 4.79,
      imageUrl: 'https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?auto=format&fit=crop&w=800&q=80',
      category: 'Specialty',
    ),
    Product(
      id: '9',
      name: 'Iced Latte',
      description: 'Chilled espresso with cold milk over ice.',
      price: 4.99,
      imageUrl: 'https://images.unsplash.com/photo-1517487881594-2787fef5ebf7?auto=format&fit=crop&w=800&q=80',
      category: 'Cold Coffee',
    ),
  ];
}
