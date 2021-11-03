import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
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

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: ElevatedButton(
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
          title: "1",
          body:
          "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('b1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "2",
          body:
          "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buildImage('b2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kids and teens",
          body:
          "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: _buildImage('b3.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: Container(
        margin: EdgeInsets.only(top: 200),
        alignment: Alignment.center,
        height: 50,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.red ,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Text('Skip',style: TextStyle(fontSize: 19.0,color: Colors.white),),
      ),
      next:Container(
        margin: EdgeInsets.only(top: 200),
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.blue ,
          borderRadius: BorderRadius.all(Radius.circular(100.0)),
        ),
        child:Icon(Icons.arrow_forward,color: Colors.white ,) ,
      ) ,
      done:  Container(
        margin: EdgeInsets.only(top: 200),
        alignment: Alignment.center,
        height: 50,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.blue ,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Text('Start',style: TextStyle(fontSize: 19.0,color: Colors.white),),
      ),

      dotsDecorator: const DotsDecorator(
        activeShape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        size: Size(10.0, 10.0),
        color:Colors.orangeAccent,
        activeSize: Size(20.0,10.0),
      ),

    );
  }
}