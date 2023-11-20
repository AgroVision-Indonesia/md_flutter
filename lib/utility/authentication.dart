import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:md_flutter/module/auth/screen/login/login_view_model.dart';
import 'package:md_flutter/module/auth/screen/register/register_view_model.dart';
import 'package:provider/provider.dart';
import '../module/auth/screen/login/login_view.dart';
import '../module/auth/screen/splash_screen/splash_screen_view_model.dart';
import '../module/profile/screen/main_profile/main_profile_view_model.dart';
import 'firebase_options.dart';

class Authentication {


  Authentication() {}

  static void initializeFirebase () async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // await FirebaseAuth.instance.useAuthEmulator('localhost', 5575);
  }

  static void checkAuth ({required BuildContext context}) {
    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      FirebaseAuth.instance
          .userChanges()
          .listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
          SplashScreenViewModel.startOnboard(context: context);
        } else {
          print('User is signed in!');
          LoginViewModel.onCallBackLogin(context: context);
          // getData();
        }
      });
    });
  }

  static void signInWithEmailPassword({required BuildContext context}) async {
    final loginViewModel = context.read<LoginViewModel>();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginViewModel.emailController.text,
          password: loginViewModel.passwordController.text
      );
      LoginViewModel.onCallBackLogin(context: context);
    } on FirebaseAuthException catch (e) {
      var error;
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
      } else if (e.code == 'channel-error') {
        error = 'Field is empty.';
      } else if (e.code == 'invalid-email') {
        error = 'The email address is badly formatted.';
      } else {
        error = 'Error logging in. Try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          content: error,
          context: context,
        ),
      );
    }
  }

  static void signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
      navigateToLoginScreen(context: context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          content: 'Error signing out. Try again.',
          context: context,
        ),
      );
    }
  }

  static void navigateToLoginScreen({required BuildContext context}) {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }

  static SnackBar customSnackBar({required String content, required BuildContext context}) {
    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.25, vertical: 10),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(4)),
        child: Text(
          content,
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}