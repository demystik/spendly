import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  late final StreamSubscription<User?> _authSubscription;

  AuthProvider() {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((_) {
      notifyListeners();
    });
  }

  bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}
