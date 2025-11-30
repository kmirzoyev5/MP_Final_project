import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/order.dart';
import 'cart_provider.dart';

class OrderProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  Future<void> fetchOrders() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: user.uid)
          .orderBy('dateTime', descending: true)
          .get();

      _orders = snapshot.docs
          .map((doc) => OrderModel.fromFirestore(doc.data(), doc.id))
          .toList();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching orders: $e');
      }
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final timestamp = DateTime.now();
    try {
      await _firestore.collection('orders').add({
        'userId': user.uid,
        'amount': total,
        'dateTime': timestamp,
        'status': 'Pending',
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'name': cp.name,
                  'price': cp.price,
                  'imageUrl': cp.imageUrl,
                  'quantity': cp.quantity,
                })
            .toList(),
      });
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error adding order: $e');
      }
      rethrow;
    }
  }
}
