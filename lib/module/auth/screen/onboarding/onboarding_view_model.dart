import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  bool statusClose = false;
  int currentPage = 0;
  final PageController pageBoardController = PageController(initialPage: 0);
  List onboardData = [
    {
      'image': 'assets/onboarding/onboard_1.png',
      'desc': 'Selamat datang di AgroVision! Mari mulai ....'
    },
    {
      'image': 'assets/onboarding/onboard_2.png',
      'desc': 'Temukan kematangan optimal buah dan tangani penyakit tanaman secara efektif'
    },
    {
      'image': 'assets/onboarding/onboard_3.png',
      'desc': 'Tingkatkan hasil panen anda dengan Agrovision'
    },
  ];

  OnboardingViewModel() {}

  void close() {
    var duration = const Duration(seconds: 2);
    Timer(duration, () {
      statusClose = false;
      notifyListeners();
    });
  }

  Future<bool> onBoardingClose({required BuildContext context}) {
    if (statusClose == true) {
      exit(0);
    }
    var snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.25, vertical: 10),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(4)),
        child: const Text(
          "Tekan sekali lagi untuk keluar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    statusClose = true;
    notifyListeners();
    close();
    return Future.value(false);
  }

  void onPageChanged(int value) {
    currentPage = value;
    notifyListeners();
  }

  void onTapNextPage({required BuildContext context}) {
    if (currentPage < onboardData.length - 1) {
      pageBoardController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    }
    if (currentPage == onboardData.length - 1) {
      // Navigator.of(context).pushNamed('/onboarding2');
    }
    notifyListeners();
  }
}
