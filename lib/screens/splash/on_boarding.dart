import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/main.dart';
import 'package:o_travel/screens/auth/choose_page.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  String _lang = 'en';
  void _changeLanguage() async {
    Locale _locale = await setLocale(_lang);
    MyApp.setLocale(context, _locale);
  }
  void _onIntroEnd(context) {
    SharedPreferences.getInstance().then((value) => value.setBool('isFirstTime', false));
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ChoosePage()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    Size size = MediaQuery.of(context).size;

    late PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      pageColor: Theme.of(context).backgroundColor,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Theme.of(context).backgroundColor,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.language_outlined,
                    color: Colors.blueGrey,
                    size: 30,
                  ),
                  onPressed: () => _changeLanguage(),
                ),
                TextButton(
                  child: Text(
                    getTranslated(context, 'skip'),
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _onIntroEnd(context),
                )
              ],
            ),
          ),
        ),
      ),

      pages: [
        PageViewModel(
          title: getTranslated(context, 'start_from_here'),
          body: getTranslated(context, 'start_from_here_desc'),
          image: _buildImage('b1.png', size.width),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: getTranslated(context, 'book'),
          body: getTranslated(context, 'book_desc'),
          image: _buildImage('b2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: getTranslated(context, 'end_here'),
          body: getTranslated(context, 'end_here_desc'),
          image: _buildImage('b3.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      next: Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(100.0)),
        ),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
      done: Container(
        alignment: Alignment.center,
        height: 50,
        width: 90,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Text(
          getTranslated(context, 'start'),
          style: TextStyle(fontSize: 19.0, color: Colors.white),
        ),
      ),

      dotsDecorator: const DotsDecorator(
        activeColor: primaryColorDark,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeSize: Size(20.0, 10.0),
      ),
    );
  }
}
