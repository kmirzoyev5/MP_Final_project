import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FavoritesProvider with ChangeNotifier {
  List<String> _favoriteIds = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> get favoriteIds => [..._favoriteIds];

  bool isFavorite(String id) => _favoriteIds.contains(id);

  Future<void> fetchFavorites() async {
    final user = _auth.currentUser;
    if (user == null) return;
    try {
      final doc = await _firestore.collection('users').doc(user.uid).collection('favorites').doc('list').get();
      if (doc.exists) {
        _favoriteIds = List<String>.from(doc.data()?['ids'] ?? []);
        notifyListeners();
      }
    } catch (e) { print(e); }
  }

  Future<void> toggleFavorite(String id) async {
    final user = _auth.currentUser;
    if (user == null) return;
    
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
    
    await _firestore.collection('users').doc(user.uid).collection('favorites').doc('list').set({'ids': _favoriteIds});
  }
}