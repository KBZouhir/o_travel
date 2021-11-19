import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/auth/reset/email.dart';
import 'package:o_travel/screens/favories/favories.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/screens/searche/result.dart';
import 'package:o_travel/screens/searche/searche.dart';
import 'package:o_travel/screens/splash/on_boarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
                debugShowCheckedModeBanner: false, home: Splash());
          } else {
            return ValueListenableBuilder<ThemeMode>(
                valueListenable: themeNotifier,
                builder: (_, ThemeMode currentMode, __) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Demo',
                    darkTheme: ThemeData(
                      primarySwatch: Colors.grey,
                      primaryColor: primaryColorDark,
                      brightness: Brightness.dark,
                      backgroundColor: Color.fromRGBO(25, 25, 25, 1),
                      accentColor: whiteColor,
                      accentIconTheme: IconThemeData(color: gray148),
                      dividerColor: gray70,
                      iconTheme: IconThemeData(color: Colors.white),
                    ),
                    themeMode: currentMode,
                    theme: ThemeData(
                      primarySwatch: Colors.grey,
                      primaryColor: primaryColorDark,
                      brightness: Brightness.light,
                      backgroundColor: Colors.white,
                      accentColor: Colors.black54,
                      accentIconTheme: IconThemeData(color: Colors.white),
                      dividerColor: Colors.white54,
                      iconTheme: IconThemeData(color: Colors.black87),
                    ),
                    home: FavoriesScreen(),
                  );
                });
          }
        });
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Color.fromRGBO(25, 25, 25, 1),
      body: Center(
          child: Image.asset(
        'assets/images/logo.png',
        height: screenHeight / 4,
        width: screenHeight / 4,
      )),
    );
  }
}

class Init {
  Init._();

  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
