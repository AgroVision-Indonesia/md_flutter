import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../../home/screen/main_menu/main_menu_view.dart';
import '../onboarding/onboarding_view.dart';

class SplashScreenViewModel extends ChangeNotifier {
  SplashScreenViewModel() {}

  static void startOnboard({required BuildContext context}) {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (context) => const OnboardingScreen(),
    ));
  }
}
