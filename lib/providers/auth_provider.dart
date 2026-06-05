import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AppStatus { loading, unauthenticated, needsIncome, authenticated }

class AppAuthProvider extends ChangeNotifier {
  User? user;
  bool incomeSet = false;

  AppStatus status = AppStatus.loading;

  AppAuthProvider() {
    FirebaseAuth.instance.authStateChanges().listen(_onAuthChanged);
  }

  void refresh(){
    notifyListeners();
  }

  void setIncomeDone(){
    incomeSet = true;
    status = AppStatus.authenticated;
    notifyListeners();
  }

  Future<void> _onAuthChanged(User? user) async {
    this.user = user;

    if (user == null) {
      status = AppStatus.unauthenticated;
      notifyListeners();
      return;
    }

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();


    if(!doc.exists){
      incomeSet = false;
    } else{
     incomeSet = doc.data()?['incomeSet'] ?? false;
    }

    status = incomeSet ? AppStatus.authenticated : AppStatus.needsIncome;

    notifyListeners();
  }

  //Getters for user Infos
  String get username => user?.displayName ?? "Spendly user";
  String get email => user?.email ?? "No Email";
  String? get photoUrl => user?.photoURL;

  bool get isLoggedIn => user != null;
}
