import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  bool get isAdmin => _user?.email == 'admin@mail.com';

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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

  Future<void> updateUserProfile({String? name, String? email}) async {
    try {
      if (_user == null) return;

      if (name != null && name != _user!.displayName) {
        await _user!.updateDisplayName(name);
      }

      if (email != null && email != _user!.email) {
        // Note: Updating email might require re-authentication if the session is old.
        // For now, we'll try a direct update.
        await _user!.updateEmail(email);
      }

      await _user!.reload();
      _user = _auth.currentUser;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
