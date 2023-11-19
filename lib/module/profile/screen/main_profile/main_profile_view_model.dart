import 'package:flutter/material.dart';

class MainProfileViewModel extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isEdit = false;
  bool isObscured1 = true;
  bool isObscured2 = true;

  MainProfileViewModel() {
    name.text = 'Rama Htamah';
    email.text = 'ramahtamah@gmail.com';
    password.text = 'TESTTESTTEST';
    notifyListeners();
  }

  onTapEditButton() {
    isEdit = !isEdit;
    notifyListeners();
  }

  void onChangeIsObscuredText1() {
    isObscured1 = !isObscured1;
    notifyListeners();
  }

  void onChangeIsObscuredText2() {
    isObscured2 = !isObscured2;
    notifyListeners();
  }
}
