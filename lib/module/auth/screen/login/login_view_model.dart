import 'package:flutter/cupertino.dart';
import 'package:md_flutter/module/auth/screen/register/register_view.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscured = true;
  LoginViewModel() {}

  void onChangeIsObscuredText() {
    isObscured = !isObscured;
    notifyListeners();
  }

  void navigateToSignUpScreen({required BuildContext context}) {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => const RegisterScreen(),
    ));
  }
}
