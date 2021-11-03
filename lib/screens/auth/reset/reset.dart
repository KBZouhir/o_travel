import 'package:flutter/material.dart';
import 'package:o_travel/screens/auth/sign_up_page.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({Key? key}) : super(key: key);

  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  bool showPassword = true;
  bool showConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body:SingleChildScrollView(child:  Stack(
          children: [
            Column(
              children: [
                Container(
                  height: size.height / 4.5,
                  width: size.width,
                  color: Colors.blue,
                ),Container(
                  height: size.height -(size.height / 4.5),
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
                          'Reset Your password',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          height: 60,
                        ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:   Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(
                          'Password',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                              color: Colors.black87),
                        ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                                color: Colors.black87),
                            obscureText: showPassword,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50))),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: showPassword
                                    ? Icon(Icons.remove_red_eye)
                                    : Icon(Icons.visibility_off_outlined),
                                onPressed: () => setState(() => showPassword = !showPassword),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Confirm new password',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: 15,
                          ),TextField(
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                                color: Colors.black87),
                            obscureText: showConfirmPassword,
                            decoration: InputDecoration(
                              hintText: 'Confirm new password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50))),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: showPassword
                                    ? Icon(Icons.remove_red_eye)
                                    : Icon(Icons.visibility_off_outlined),
                                onPressed: () => setState(
                                        () => showConfirmPassword = !showConfirmPassword),
                              ),
                            ),
                          ),],),),
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));

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
                            onPressed: () => print("Successful Login."),
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
