import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:md_flutter/module/auth/screen/splash_screen/splash_screen_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../utility/authentication.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashScreenViewModel>(
      create: (context) {
        return SplashScreenViewModel();
      },
      builder: (context, child) {
        return const SplashScreenView();
      },
    );
  }
}

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    Authentication.checkAuth(context: context);
    super.initState();
  }

  void showToast(String message) {
    Flushbar(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8),
      message: message,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        // ================ logo ================
        Center(
          // child: Image.network('https://onesmile.sinarmasland.com/api/img/splash/logo.png',
          //   fit: BoxFit.contain,
          //   width: MediaQuery.of(context).size.width * 0.7,
          // ),
          child: Image.asset(
            'assets/logo_splash.png',
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
        ),
      ],
    ));
  }
}
