import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  bool get isLogin => auth.currentUser != null;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> register(String email, String password) async {
    try {
      print('register email$email');
      print('register password$password');

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      await user.sendEmailVerification();
      print('user $user');
      // if (user != null) {
      //   this._userService.createUser(user);
      // }
      return user;
    } on FirebaseAuthException catch (e) {
      print('register error ${e.toString()}');
      if (e.code == 'weak-password') {
        // Notifications.error(e.message);
      } else if (e.code == 'email-already-in-use') {
        // Notifications.error(e.message);
      }
    } catch (e) {
      print('register error ${e.toString()}');

      // Notifications.error(e.message);
    }
    return null;
  }

  Future<User> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: "$email", password: password);
      User user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        // Notifications.error(e.message);
      } else if (e.code == 'user-not-found') {
        // Notifications.error(e.message);
      } else if (e.code == 'wrong-password') {
        // Notifications.error(e.message);
      } else if (e.code == 'user-disabled') {
        // Notifications.error(e.message);
      }
    } catch (e) {
      // Notifications.error(e.message);
    }
    return null;
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<User> loginOrCreateAccount(bool newAccount, String email,
      String password, BuildContext context) async {
    return newAccount ? signIn(email, password) : register(email, password);
  }
}
