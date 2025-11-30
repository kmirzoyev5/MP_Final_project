import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  bool get isAdmin => _user?.email == 'admin@mail.com';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? _userProfile;

  Map<String, dynamic>? get userProfile => _userProfile;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      if (user != null) {
        _fetchUserProfile();
      } else {
        _userProfile = null;
        notifyListeners();
      }
    });
  }

  Future<void> _fetchUserProfile() async {
    if (_user == null) return;
    try {
      final doc = await _firestore.collection('users').doc(_user!.uid).get();
      if (doc.exists) {
        _userProfile = doc.data();
      } else {
        // Initialize profile if it doesn't exist
        _userProfile = {
          'name': _user!.displayName ?? '',
          'email': _user!.email ?? '',
          'phoneNumber': '',
          'joinDate': DateTime.now().toIso8601String(),
        };
        await _firestore.collection('users').doc(_user!.uid).set(_userProfile!);
      }
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user profile: $e');
      }
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Create initial user profile in Firestore
      if (credential.user != null) {
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'name': '',
          'email': email,
          'phoneNumber': '',
          'joinDate': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> updateUserProfile({String? name, String? email, String? phoneNumber}) async {
    try {
      if (_user == null) return;

      final updates = <String, dynamic>{};

      if (name != null) {
        await _user!.updateDisplayName(name);
        updates['name'] = name;
      }

      if (email != null && email != _user!.email) {
        await _user!.updateEmail(email);
        updates['email'] = email;
      }

      if (phoneNumber != null) {
        updates['phoneNumber'] = phoneNumber;
      }

      if (updates.isNotEmpty) {
        await _firestore.collection('users').doc(_user!.uid).update(updates);
        // Refresh local profile
        await _fetchUserProfile();
      }

      await _user!.reload();
      _user = _auth.currentUser;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
