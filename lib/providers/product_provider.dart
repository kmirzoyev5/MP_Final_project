import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    try {
      final snapshot = await _firestore.collection('products').get();
      _products = snapshot.docs
          .map((doc) => Product.fromFirestore(doc.data(), doc.id))
          .toList();
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products: $e');
      }
    }
  }
}
