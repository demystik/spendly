import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signInWithGoogle() async {
    try {
      // Pick Google account
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return;
      }

      // Get auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in Firebase
      final userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      if (user == null) {
        return;
      }

      // Save user if first login
      await _saveUserIfNeeded(
        uid: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? 'User',
      );
    } catch (e) {
      throw Exception('Google Sign-In failed: $e');
    }
  }

  Future<void> _saveUserIfNeeded({
    required String uid,
    required String email,
    required String name,
  }) async {
    final userDoc = await _firestore.collection('users').doc(uid).get();

    if (!userDoc.exists) {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'name': name,
        'incomeSet': false,
        'joinedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();

    await _auth.signOut();
  }
}
