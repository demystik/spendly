import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:spendly/models/expense_model.dart';

Future<void> deleteAccount(BuildContext context) async {
  try {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    // Re-authenticate Google user
    final googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await user.reauthenticateWithCredential(credential);

    // Delete firestore user document
    await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

    // Clear Hive local DB
    await Hive.box<Expense>('expensesBox').clear();

    // Delete Firebase auth account
    await user.delete();

    // Sign out Google
    await GoogleSignIn().signOut();

    if (context.mounted) {
      context.go('/login');
    }
  } on FirebaseAuthException catch (e) {
    debugPrint(e.code);

    if(!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.message ?? 'Failed to delete account')),
    );
  } catch (e) {
    debugPrint(e.toString());

    if(!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Something went wrong')));
  }
}
