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

  static Future<String> signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance //
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return 'Welcome!';
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  static Future<String?> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      userCredential.user?.sendEmailVerification();

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for thar user';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> forgotPassword({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> sendEmailVerification() async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();

      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

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
