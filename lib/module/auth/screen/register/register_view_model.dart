import 'package:flutter/cupertino.dart';

class RegisterViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isObscured1 = true;
  bool isObscured2 = true;

  RegisterViewModel() {}

  void onChangeIsObscuredText1() {
    isObscured1 = !isObscured1;
    notifyListeners();
  }

  void onChangeIsObscuredText2() {
    isObscured2 = !isObscured2;
    notifyListeners();
  }

  void navigateToLoginScreen({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}
