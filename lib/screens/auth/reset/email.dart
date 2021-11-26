import 'package:flutter/material.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/auth/reset/verify.dart';
import 'package:o_travel/screens/localization/const.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: size.height / 2.5,
                width: size.width,
                color: Theme.of(context).primaryColor,
              ),
              Container(
                height: size.height - (size.height / 2.5),
                width: size.width,
                color: Theme.of(context).backgroundColor,
              )
            ],
          ),
          Positioned(
              top: size.height * 0.07,
              right: 0,
              left: 0,
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                                size: 40,
                              )),                          Spacer(),

                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        getTranslated(context, 'forgot_password'),
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        getTranslated(context, 'forgot_password_text'),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                        width: size.width * 0.9,
                        height: 250,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(2, 2),
                                blurRadius: 15,
                                color: Colors.grey.withOpacity(0.4),
                              )
                            ],
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              getTranslated(context, 'email'),
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TextField(
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25.0,
                                  color: Colors.black87),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(raduice),
                        ),
                        child: MaterialButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyPage())),
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            getTranslated(context, 'send_code'),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )))
        ],
      ),
    ));
  }
}
