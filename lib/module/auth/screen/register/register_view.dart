import 'package:flutter/material.dart';
import 'package:md_flutter/component/custom_text_input.dart';
import 'package:md_flutter/module/auth/screen/register/register_view_model.dart';
import 'package:md_flutter/utility/constant.dart';
import 'package:provider/provider.dart';
import '../../../../utility/authentication.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
      create: (context) {
        return RegisterViewModel();
      },
      builder: (context, child) => const RegisterView(),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RegisterViewModel>();
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4), // Adjust opacity as needed
            BlendMode.srcATop, // Blend mode can be changed as needed
          ),
          child: Stack(
            children: [
              Image.asset(
                'assets/auth/bg_auth.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4), // Shadow color
                        blurRadius: 10.0, // Adjust the blur radius as needed
                        spreadRadius: 2.0, // Adjust the spread radius as needed
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SafeArea(
            child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              SizedBox(
                width: 180,
                height: 52,
                child: Image.asset(
                  'assets/auth/icon_auth.png',
                  fit: BoxFit.contain,
                  width: 180,
                  height: 52,
                  // height: MediaQuery.of(context).size.height,
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              const Text(
                "Tagline",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              const Text(
                "Create your account",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 44),
                child: Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextInput(
                      controllerName: viewModel.nameController,
                      placeholder: "Nama",
                      hintText: "Nama",
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomTextInput(
                      controllerName: viewModel.emailController,
                      placeholder: "Email",
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomTextInput(
                      controllerName: viewModel.passwordController,
                      placeholder: "Password",
                      hintText: "Password",
                      keyboardType: TextInputType.text,
                      isObsecure: viewModel.isObscured1,
                      suffixIcon: InkWell(
                        onTap: () {
                          viewModel.onChangeIsObscuredText1();
                        },
                        child:
                            Icon(viewModel.isObscured1 ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomTextInput(
                      controllerName: viewModel.confirmPasswordController,
                      placeholder: "Confirm Password",
                      hintText: "Confirm Password",
                      keyboardType: TextInputType.text,
                      isObsecure: viewModel.isObscured2,
                      suffixIcon: InkWell(
                        onTap: () {
                          viewModel.onChangeIsObscuredText2();
                        },
                        child:
                            Icon(viewModel.isObscured2 ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    InkWell(
                      onTap: () {
                        Authentication.createUserWithEmailAndPassword(context: context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32), color: Constant.greenDark),
                        child: const Text(
                          "Sign Up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                )),
              )
            ])),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sudah memiliki akun? ",
                    style:
                        TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      viewModel.navigateToLoginScreen(context: context);
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white, // You can set the underline color
                          decorationThickness: 1.5,
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            )
          ],
        ))
      ]),
    );
  }
}
