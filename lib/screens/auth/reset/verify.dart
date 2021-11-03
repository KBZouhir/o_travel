import 'package:flutter/material.dart';
import 'package:o_travel/screens/auth/reset/reset.dart';
import 'package:o_travel/screens/auth/sign_up_page.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body:SingleChildScrollView(child:  Stack(
          children: [
            Column(
              children: [
                Container(
                  height: size.height / 2.5,
                  width: size.width,
                  color: Colors.blue,
                ),Container(
                  height: size.height -(size.height / 2.5),
                  width: size.width,
                  color: Colors.white,
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
                        Align(
                          child: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 40,
                          ),
                          alignment: Alignment.topLeft,
                        ),SizedBox(height: 10,),
                        Text(
                          'Forgot Your Password?',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '''Please Enter the Code You \nReceive on you're Email''',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 40),
                          width: size.width*0.9,
                          height: size.height * 0.30,
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(
                                offset: Offset(2,2),
                                blurRadius: 15,
                                color: Colors.grey.withOpacity(0.4),
                              )],
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          child:Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Code',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),SizedBox(
                                height: 40,
                              ),
                              TextField(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25.0,
                                    color: Colors.black87),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          '''Didn't receive any code? ''',
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                          textAlign: TextAlign.center,
                        ),

                        TextButton(
                            onPressed: () {


                            },
                            child:Text(
                              'Resend Code',
                              style: TextStyle(fontSize: 20, color: Colors.blue),
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                          height:35,
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: MaterialButton(
                            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPage())),
                            color: Colors.blue,
                            child: Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                      ],
                    )))
          ],
        )));
  }
}
