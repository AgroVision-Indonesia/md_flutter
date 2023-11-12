import 'package:flutter/material.dart';
import 'package:md_flutter/module/auth/model/onboard_data.dart';
import 'package:md_flutter/module/auth/screen/onboarding/onboarding_view_model.dart';
import 'package:md_flutter/utility/constant.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return OnboardingViewModel();
      },
      builder: (context, child) => const OnboardingScreenView(),
    );
  }
}

class OnboardingScreenView extends StatelessWidget {
  const OnboardingScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OnboardingViewModel>();
    return WillPopScope(
        onWillPop: () {
          return viewModel.onBoardingClose(context: context);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: viewModel.onboardDataList.isNotEmpty
              ? const OnboardingBottomNavbar()
              : const SizedBox(),
          body: SafeArea(
              child: viewModel.onboardDataList.isNotEmpty
                  ? PageView.builder(
                      controller: viewModel.pageBoardController,
                      onPageChanged: (value) {
                        viewModel.onPageChanged(value);
                      },
                      itemCount: viewModel.onboardDataList.length,
                      itemBuilder: (context, index) {
                        OnboardData item = viewModel.onboardDataList[index];
                        return OnboardingContent(title: item.desc, image: item.image);
                      },
                    )
                  : const SizedBox()),
        ));
  }
}

class OnboardingBottomNavbar extends StatelessWidget {
  const OnboardingBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OnboardingViewModel>();
    return BottomAppBar(
      height: 150,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                viewModel.onboardDataList.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 5),
                  height: viewModel.currentPage == index ? 12 : 8,
                  width: viewModel.currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                      color: viewModel.currentPage == index
                          ? Colors.black
                          : Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Constant.greenDark,
                borderRadius: BorderRadius.circular(32),
              ),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  viewModel.onTapNextPage(context: context);
                },
                borderRadius: BorderRadius.circular(32),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                  child: Text(
                    viewModel.currentPage == viewModel.onboardDataList.length - 1
                        ? "Mulai Sekarang"
                        : "Selanjutnya",
                    style: const TextStyle(
                        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);
  final String title, image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
          Image.asset(
            image,
            height: MediaQuery.of(context).size.width * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
        ],
      ),
    );
  }
}
