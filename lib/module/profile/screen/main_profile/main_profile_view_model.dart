import 'package:flutter/material.dart';
import 'package:md_flutter/utility/authentication.dart';

class MainProfileViewModel extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool isEdit = false;
  bool isObscured1 = true;
  bool isObscured2 = true;

  MainProfileViewModel() {
    print(Authentication.provider);
    print(Authentication.uid);
    print(Authentication.profilePhoto);
    print(Authentication.name);
    print(Authentication.emailAddress);
    print(Authentication.password);
    name.text = Authentication.name.toString();
    email.text = Authentication.emailAddress.toString();
    // password.text = password.toString();
    // name.text = 'Rama Htamah';
    // email.text = 'ramahtamah@gmail.com';
    // password.text = 'TESTTESTTEST';
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
