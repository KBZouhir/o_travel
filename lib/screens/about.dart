import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/screens/localization/const.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar( context),
        body:SingleChildScrollView(
          child:  Container(
            height: 700,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/about.png',
                  ),
                ),
                SizedBox(
                  height:20,
                ),
                Text(
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, '
                        'consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt.',
                    style: TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: Theme.of(context).accentColor),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Spacer(),
                    Icon(Icons.email_outlined, size: 22,color: Theme.of(context).accentColor,),
                    SizedBox(
                      width:10,
                    ),
                    Text(
                        "otravel2040@gmail.com",
                        style: TextStyle(color: Theme.of(context).accentColor,fontSize: 16)
                    ),
                    Spacer(),

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Spacer(),
                    Icon(Icons.phone, size: 22,color: Theme.of(context).accentColor,),
                    SizedBox(
                      width:10,
                    ),
                    Text(
                        "+96878085137",
                        style: TextStyle(color: Theme.of(context).accentColor,fontSize: 16)
                    ),
                    Spacer(),
                    Icon(Icons.location_on_outlined, size: 22,color: Theme.of(context).accentColor,),
                    SizedBox(
                      width:10,
                    ),
                    Text(
                        "Oman - Muscat",
                        style: TextStyle(color: Theme.of(context).accentColor,fontSize: 16)
                    ),
                    Spacer(),

                  ],
                ),
              ],
            ),
          ),
        ) );
  }
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme,
      toolbarHeight: 50,
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          )),
      title: Center(
          child: Text(getTranslated(context, 'about'),
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          )),
      actions: [
        SizedBox(
          width: 55,
        )
      ],
    );
  }

}
