
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:o_travel/api/company/api.dart';
import 'package:o_travel/screens/localization/const.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  String privacy_='';
  bool  loading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    privacy().then((value){
      setState(() {
        privacy_=value;
        loading=false;
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            height: 700,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child:loading?GFLoader(): Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
            Html(
              data: privacy_,
              ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
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
          child: Text(
            getTranslated(context, 'privacy_policy'),
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
