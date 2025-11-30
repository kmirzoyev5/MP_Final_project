import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/order.dart';

class AdminProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  List<OrderModel> _allOrders = [];
  List<Map<String, dynamic>> _allUsers = [];
  Map<String, dynamic> _stats = {};

  List<OrderModel> get allOrders => _allOrders;
  List<Map<String, dynamic>> get allUsers => _allUsers;
  Map<String, dynamic> get stats => _stats;

  // Product Management
  Future<void> addProduct(Product product) async {
    try {
      if (kDebugMode) {
        print('Adding product: ${product.name}');
      }
      await _firestore.collection('products').add(product.toMap());
      if (kDebugMode) {
        print('Product added successfully');
      }
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error adding product: $e');
      }
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _firestore
          .collection('products')
          .doc(product.id)
          .update(product.toMap());
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Order Management
  Future<void> fetchAllOrders() async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .orderBy('dateTime', descending: true)
          .get();
      
      _allOrders = snapshot.docs
          .map((doc) => OrderModel.fromFirestore(doc.data(), doc.id))
          .toList();
      
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching orders: $e');
      }
    }
  }

  // User Management
  Future<void> fetchAllUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      _allUsers = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'email': data['email'] ?? '',
          'displayName': data['displayName'] ?? '',
          'createdAt': data['createdAt'],
        };
      }).toList();
      
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching users: $e');
      }
    }
  }

  // Dashboard Statistics
  Future<void> getDashboardStats() async {
    try {
      final productsCount = await _firestore.collection('products').count().get();
      final ordersCount = await _firestore.collection('orders').count().get();
      final usersCount = await _firestore.collection('users').count().get();
      
      _stats = {
        'products': productsCount.count ?? 0,
        'orders': ordersCount.count ?? 0,
        'users': usersCount.count ?? 0,
      };
      
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching stats: $e');
      }
    }
  }
}
