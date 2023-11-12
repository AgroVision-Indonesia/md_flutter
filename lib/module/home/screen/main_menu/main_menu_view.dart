import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:md_flutter/module/home/screen/home/home_view.dart';
import 'package:md_flutter/utility/constant.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int selectedIndex = 0;

  onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget body() {
    List pages = [
      const Home(),
      const Home(),
      const Home(),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          // selectedFontSize: 12,
          // unselectedFontSize: 12,
          // selectedLabelStyle: TextStyle(color: Constant.greenMedium),
          // selectedItemColor: Constants.redonesmile,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          backgroundColor: Constant.greenDark,

          type: BottomNavigationBarType.fixed,
          elevation: 0.0,
          currentIndex: selectedIndex,
          onTap: onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: selectedIndex == 0
                  ? const Icon(IconlyLight.home)
                  : const Icon(
                      IconlyBroken.home,
                      color: Colors.white,
                    ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 1
                  ? const Icon(IconlyLight.scan)
                  : const Icon(
                      IconlyBroken.scan,
                      color: Colors.white,
                    ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: selectedIndex == 2
                  ? const Icon(IconlyLight.profile)
                  : const Icon(
                      IconlyBroken.profile,
                      color: Colors.white,
                    ),
              label: '',
            ),
          ],
        ),
        body: pages[selectedIndex],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: body(),
      ),
    );
  }
}
