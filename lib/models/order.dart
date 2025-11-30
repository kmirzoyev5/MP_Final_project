import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/cart_provider.dart';

class OrderModel {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final String status;

  OrderModel({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
    required this.status,
  });

  factory OrderModel.fromFirestore(Map<String, dynamic> data, String id) {
    return OrderModel(
      id: id,
      amount: (data['amount'] ?? 0).toDouble(),
      products: (data['products'] as List<dynamic>)
          .map((item) => CartItem(
                id: item['id'],
                name: item['name'],
                price: (item['price'] ?? 0).toDouble(),
                imageUrl: item['imageUrl'] ?? '',
                quantity: item['quantity'] ?? 1,
              ))
          .toList(),
      dateTime: (data['dateTime'] as Timestamp).toDate(),
      status: data['status'] ?? 'Pending',
    );
  }
}
