import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

sealed class AuthService {
  static Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth //
          .instance
          .signInWithCredential(credential);

      return 'Welcome!';
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  //delete account
  static Future<String> deleteAccount() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance //
          .collection('tasks')
          .where('userId', isEqualTo: user?.uid)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });

      await user?.delete();

      return 'Account deleted';
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }
}
