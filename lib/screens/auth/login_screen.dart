import 'package:flutter/material.dart';
import 'package:o_travel/screens/auth/reset/email.dart';
import 'package:o_travel/screens/auth/sign_up_page.dart';
import 'package:o_travel/screens/home/home.dart';
class LoginScreen extends StatefulWidget {
  final bool company;
  const LoginScreen({Key? key,required this.company}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,

        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Center(
            child: Text(
          'LOGIN',
          style: TextStyle(fontSize: 25, color:Theme.of(context).primaryColor),
        )),
        leading: IconButton(
          icon: Icon(Icons.language_outlined,color: Colors.blueGrey,size: 30,),
          onPressed: () =>
              setState(() => showPassword = !showPassword),
        ),
        actions: [SizedBox(width: 55,)],

      ),
      body: Container(
        color:Theme.of(context).backgroundColor,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  child: Image.asset('assets/images/logo.png', width: 100),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Username or email',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    prefixIcon: Icon(
                      Icons.perm_identity,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  'Password',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,color: Theme.of(context).accentColor),
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
                      onPressed: () =>
                          setState(() => showPassword = !showPassword),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EmailPage()));

                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Theme.of(context).accentColor.withOpacity(0.7),
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: MaterialButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen())),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                widget.company?Center() : Column(children: [ Center(child:  Text(
                 'Sign in with',
                 style: TextStyle(
                   fontWeight: FontWeight.w500,
                   color: Theme.of(context).accentColor,
                   fontSize: 16.0,
                 ),),),
                 SizedBox(
                   height: 15,
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     IconButton(
                       icon: Image.asset('assets/images/google-plus.png'),
                       iconSize: 50,
                       onPressed: () {},
                     ),
                     IconButton(
                       icon: Image.asset('assets/images/facebook.png'),
                       iconSize: 50,
                       onPressed: () {},
                     ),

                   ],
                 ),],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '''Don't have an account? ''',
                      style: TextStyle(
                        color: Theme.of(context).accentColor.withOpacity(0.8),
                        fontSize: 16.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));

                      },
                      child: Text('Sign Up',style: TextStyle(
                        color:Theme.of(context).accentColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
