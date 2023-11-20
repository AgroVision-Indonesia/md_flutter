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
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginViewModel.emailController.text,
          password: loginViewModel.passwordController.text
      );
      if (userCredential.user != null) {
        LoginViewModel.onCallBackLogin(context: context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          content:
          e.toString(),
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
        ),
      );
    }
  }

  static void navigateToLoginScreen({required BuildContext context}) {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

}