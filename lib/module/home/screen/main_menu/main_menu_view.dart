import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:md_flutter/module/home/screen/home/home_view.dart';
import 'package:md_flutter/module/auth/screen/detection_home/detection_home_view.dart';
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
      const DetectionHome(),
      const Home(),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8.0,
                spreadRadius: 2.0,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: BottomNavigationBar(
            selectedFontSize: 10,
            unselectedFontSize: 10,
            selectedLabelStyle: TextStyle(color: Constant.greenDark),
            selectedItemColor: Constant.greenDark,
            // showUnselectedLabels: false,
            // showSelectedLabels: false,
            backgroundColor: Colors.white,

            type: BottomNavigationBarType.fixed,
            elevation: 0.0,
            currentIndex: selectedIndex,
            onTap: onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: selectedIndex == 0
                    ? Icon(
                        IconlyLight.home,
                      )
                    : const Icon(
                        IconlyBroken.home,
                      ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: selectedIndex == 1
                    ? Icon(
                        IconlyLight.scan,
                      )
                    : const Icon(
                        IconlyBroken.scan,
                      ),
                label: 'Deteksi',
              ),
              BottomNavigationBarItem(
                icon: selectedIndex == 2
                    ? Icon(
                        IconlyLight.profile,
                      )
                    : const Icon(
                        IconlyBroken.profile,
                      ),
                label: 'Profil',
              ),
            ],
          ),
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
