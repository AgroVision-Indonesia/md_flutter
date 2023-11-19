import 'package:flutter/material.dart';
import 'package:md_flutter/component/custom_text_input_profile.dart';
import 'package:md_flutter/module/profile/screen/main_profile/main_profile_view_model.dart';
import 'package:md_flutter/utility/constant.dart';
import 'package:provider/provider.dart';

class MainProfileScreen extends StatelessWidget {
  const MainProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProfileViewModel>(
      create: (context) {
        return MainProfileViewModel();
      },
      builder: (context, child) => MainProfileView(),
    );
  }
}

class MainProfileView extends StatelessWidget {
  const MainProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainProfileViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: SizedBox(),
        centerTitle: true,
        title: Text(
          'Profil Saya',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              viewModel.onTapEditButton();
            },
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: viewModel.isEdit ? Constant.greenDark : Colors.white,
              ),
              child: Image.asset(
                'assets/profile/edit.png',
                height: 24,
                width: 24,
                color: viewModel.isEdit ? Colors.white : Constant.greenDark,
              ),
            ),
          ),
          SizedBox(
            width: 24,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                CardUserInfo(),
                SizedBox(
                  height: 12,
                ),
                CardUserEditSection(),
                SizedBox(
                  height: 12,
                ),
                if (!viewModel.isEdit) CardMoreOptions(),
                if (viewModel.isEdit) CardSaveNewDataOptions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardSaveNewDataOptions extends StatelessWidget {
  const CardSaveNewDataOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final viewModel = context.watch<MainProfileViewModel>();
    return Card(
      elevation: 10.0,
      color: Colors.white,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {},
                  child: Container(
                    width: width * 0.3,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16), color: Constant.greenDark),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {},
                  child: Container(
                    width: width * 0.3,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16), color: Colors.red.shade900),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CardMoreOptions extends StatelessWidget {
  const CardMoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final viewModel = context.watch<MainProfileViewModel>();
    return Card(
      elevation: 10.0,
      color: Colors.white,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {},
              child: Text(
                'Pengaturan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Text(
                'Tentang',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardUserEditSection extends StatelessWidget {
  const CardUserEditSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final viewModel = context.watch<MainProfileViewModel>();
    return Card(
      elevation: 10.0,
      color: Colors.white,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          children: [
            CustomTextInputProfile(
              controllerName: viewModel.name,
              placeholder: 'Nama',
              isEnabled: viewModel.isEdit,
            ),
            SizedBox(
              height: 12,
            ),
            CustomTextInputProfile(
              controllerName: viewModel.email,
              placeholder: 'Email',
              isEnabled: viewModel.isEdit,
            ),
            SizedBox(
              height: 12,
            ),
            CustomTextInputProfile(
              controllerName: viewModel.password,
              placeholder: 'Password',
              isEnabled: viewModel.isEdit,
              isObsecure: viewModel.isObscured1,
              suffixIcon: InkWell(
                onTap: () {
                  viewModel.onChangeIsObscuredText1();
                },
                child: Icon(viewModel.isObscured1 ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            if (viewModel.isEdit)
              Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  CustomTextInputProfile(
                    controllerName: viewModel.confirmPassword,
                    placeholder: 'Konfirmasi Password',
                    isEnabled: viewModel.isEdit,
                    isObsecure: viewModel.isObscured2,
                    suffixIcon: InkWell(
                      onTap: () {
                        viewModel.onChangeIsObscuredText2();
                      },
                      child: Icon(viewModel.isObscured2 ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

class CardUserInfo extends StatelessWidget {
  const CardUserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 10.0,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Constant.greenDark,
                  radius: 31,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rama Htamah',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/profile/token_logo.png',
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '8 Token',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              width: width,
              height: 0.5,
              color: Colors.black38,
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/profile/member_logo.png',
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Free member',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16), color: Constant.greenDark),
                    child: Text(
                      'Upgrade',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
