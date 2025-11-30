import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String? size;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.size,
    this.quantity = 1,
  });
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  Future<void> fetchCart() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .get();

      _items.clear();
      for (var doc in snapshot.docs) {
        _items.putIfAbsent(
          doc.id,
          () => CartItem(
            id: doc['productId'] ?? doc.id,
            name: doc['name'],
            price: doc['price'],
            imageUrl: doc['imageUrl'],
            size: doc['size'],
            quantity: doc['quantity'],
          ),
        );
      }
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching cart: $e');
      }
    }
  }

  Future<void> _syncToFirestore() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final batch = _firestore.batch();
      final cartRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart');

      // Delete existing cart items (simplification for sync)
      // In a real app, you'd diff changes, but for now this ensures consistency
      final snapshot = await cartRef.get();
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      _items.forEach((key, item) {
        final docRef = cartRef.doc(key);
        batch.set(docRef, {
          'productId': item.id,
          'name': item.name,
          'price': item.price,
          'imageUrl': item.imageUrl,
          'size': item.size,
          'quantity': item.quantity,
        });
      });

      await batch.commit();
    } catch (e) {
      if (kDebugMode) {
        print('Error syncing cart: $e');
      }
    }
  }

  void addItem(Product product, {String? size}) {
    final cartKey = size != null ? '${product.id}_$size' : product.id;
    
    if (_items.containsKey(cartKey)) {
      _items.update(
        cartKey,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
          size: existingCartItem.size,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        cartKey,
        () => CartItem(
          id: product.id,
          name: product.name,
          price: product.price,
          imageUrl: product.imageUrl,
          size: size,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
    _syncToFirestore();
  }

  void incrementItem(String cartKey) {
    if (_items.containsKey(cartKey)) {
      _items.update(
        cartKey,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
          size: existingCartItem.size,
          quantity: existingCartItem.quantity + 1,
        ),
      );
      notifyListeners();
      _syncToFirestore();
    }
  }

  void removeSingleItem(String cartKey) {
    if (!_items.containsKey(cartKey)) {
      return;
    }
    if (_items[cartKey]!.quantity > 1) {
      _items.update(
        cartKey,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
          size: existingCartItem.size,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(cartKey);
    }
    notifyListeners();
    _syncToFirestore();
  }

  void removeItem(String cartKey) {
    _items.remove(cartKey);
    notifyListeners();
    _syncToFirestore();
  }

  void clear() {
    _items.clear();
    notifyListeners();
    _syncToFirestore();
  }
}
