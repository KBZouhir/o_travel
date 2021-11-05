import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/auth/choose_page.dart';
import 'package:o_travel/screens/auth/login_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
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
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;

    Size size = MediaQuery.of(context).size;

    late PageDecoration pageDecoration =  PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      pageColor:  Theme.of(context).backgroundColor,
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
            child: TextButton(
              child: const Text(
                'Skip',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              onPressed: () => _onIntroEnd(context),
            ),
          ),
        ),
      ),

      pages: [
        PageViewModel(
          title: "Start From Here!",
          body:
          "Are you looking for travel offers?\nAnd you don't know where to find tourist office discounts.\nI have the solution for you.",
          image: _buildImage('b1.png',size.width),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Book your flight",
          body:
          "Otravel\n We have the solution in this application.\n You get all the discounts and tourist offers to the offices in a unit platform, and you can easily choose what you want.",
          image: _buildImage('b2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Great! You are here",
          body:
          "What are you waiting for so far? Enter the app, choose what you want with strong offers and travel where you like at the best prices and without what you look for from company to company.",
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
      next:Container(
        margin: EdgeInsets.only(top: 200),
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor ,
          borderRadius: BorderRadius.all(Radius.circular(100.0)),
        ),
        child:Icon(Icons.arrow_forward,color: Colors.white ,) ,
      ) ,
      done:  Container(
        margin: EdgeInsets.only(top: 200),
        alignment: Alignment.center,
        height: 50,
        width: 90,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Text('Start',style: TextStyle(fontSize: 19.0,color: Colors.white),),
      ),

      dotsDecorator: const DotsDecorator(
        activeColor: primaryColorDark,
        activeShape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        size: Size(10.0, 10.0),
        color:Colors.grey,
        activeSize: Size(20.0,10.0),
      ),

    );
  }
}