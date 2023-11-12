import 'package:flutter/material.dart';
import 'package:md_flutter/module/home/screen/main_menu/main_menu_view.dart';
import 'package:md_flutter/module/auth/screen/splash_screen/splash_screen_view.dart';
import 'package:md_flutter/utility/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> mainKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AgroVision',
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashScreen',
        routes: routes,
        key: mainKey,
        navigatorKey: navigatorKey,
        theme: Provider.of<ThemeNotifier>(context).currentThemeData);
  }

  Map<String, Widget Function(BuildContext)> routes = {
    '/splashScreen': (BuildContext context) => const SplashScreen(),
    '/mainMenu': (BuildContext context) => const MainMenu(),
  };
}
