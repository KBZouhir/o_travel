import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:o_travel/screens/localization/demo_localisation.dart';
import 'package:o_travel/screens/splash/on_boarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFirstTime = true;
  bool isLogged = false;
  late Locale _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          SharedPreferences.getInstance().then((value) {
            print("isFirstTime ${value.getBool('isFirstTime')}");
            print("_token ${value.getString('_token')}");
            if (value.getBool('isFirstTime') != null)
              isFirstTime = value.getBool('isFirstTime')!;
            if (value.getString('_token') != null) {
              print("_token2 ${value.getString('_token')}");
              isLogged = true;
            } else
              isLogged = false;
          });
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
                debugShowCheckedModeBanner: false, home: Splash());
          } else {
            return ValueListenableBuilder<ThemeMode>(
                valueListenable: MyApp.themeNotifier,
                builder: (_, ThemeMode currentMode, __) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'O travel',
                    darkTheme: ThemeData(
                      fontFamily: 'Tajawal',
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
                      fontFamily: 'Tajawal',
                      primarySwatch: Colors.grey,
                      primaryColor: primaryColorDark,
                      brightness: Brightness.light,
                      backgroundColor: Colors.white,
                      accentColor: Colors.black54,
                      accentIconTheme: IconThemeData(color: Colors.white),
                      dividerColor: Colors.white54,
                      iconTheme: IconThemeData(color: Colors.black87),
                    ),
                    localizationsDelegates: [
                      DemoLocalization.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    locale: _locale,
                    supportedLocales: [
                      Locale('en', 'US'), // English, no country code
                      Locale('ar', 'SA'), // Spanish, no country code
                    ],
                    localeResolutionCallback: (locale, supportedLocales) {
                      for (var supportedLocale in supportedLocales) {
                        if (supportedLocale.languageCode ==
                                locale!.languageCode &&
                            supportedLocale.countryCode == locale.countryCode) {
                          return supportedLocale;
                        }
                      }
                      return supportedLocales.first;
                    },
                    home: (!isLogged ? OnBoardingPage() : HomeScreen()),
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
          : Color.fromRGBO(49, 47, 47, 1.0),
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
