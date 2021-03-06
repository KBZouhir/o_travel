import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:o_travel/api/company/auth.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/main.dart';
import 'package:o_travel/screens/auth/reset/email.dart';
import 'package:o_travel/screens/auth/sign_up_page.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:o_travel/screens/privacy.dart';
import 'package:o_travel/screens/term_of_use.dart';
import 'package:o_travel/services/auth.dart';
import 'package:o_travel/services/sheard_helper.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key,}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;
  bool isCompany = false;
  String _lang = 'en';
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getResources();

    getLocale().then((locale) {
      setState(() {
        if (locale.languageCode == 'en')
          this._lang = 'ar';
        else
          this._lang = 'en';
      });
    });
  }

  void _changeLanguage() async {
    Locale _locale = await setLocale(_lang);
    MyApp.setLocale(context, _locale);
  }

  final _auth = FirebaseAuth.instance;

  getResources() {
    FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        deviceToken = value;
      });
    });
  }

  String? deviceToken = '';


  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor ,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        title: Center(
            child: Text(
          getTranslated(context, 'login'),
          style: TextStyle(fontSize: 25, color: Theme.of(context).primaryColor),
        )),
        leading: IconButton(
          icon: Icon(
            Icons.language_outlined,
            color: Colors.blueGrey,
            size: 30,
          ),
          onPressed: () => _changeLanguage(),
        ),
        actions: [
          SizedBox(
            width: 55,
          )
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: GestureDetector(
                      onTap: (){
                        setState(() {
                          this.isCompany=false;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(raduice),
                            color: isCompany?Theme.of(context).backgroundColor:Theme.of(context).primaryColor
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            getTranslated(context, 'individuals'),
                            style: TextStyle(fontSize: 22,color:isCompany?Theme.of(context).primaryColor:Colors.white ),
                          ),
                        ),
                      ),
                    )),
                    Expanded(child: GestureDetector(
                      onTap: (){
                        setState(() {
                          this.isCompany=true;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(raduice),
                            color: !isCompany?Theme.of(context).backgroundColor:Theme.of(context).primaryColor
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            getTranslated(context, 'companies'),
                            style: TextStyle(fontSize: 22,color:!isCompany?Theme.of(context).primaryColor:Colors.white ),
                          ),
                        ),
                      ),
                    ))

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  getTranslated(context, 'username') +
                      ' ' +
                      getTranslated(context, 'or') +
                      ' ' +
                      getTranslated(context, 'email'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: usernameController,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.secondary),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: getTranslated(context, 'username') +
                        ' ' +
                        getTranslated(context, 'or') +
                        ' ' +
                        getTranslated(context, 'email'),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(raduice))),
                    prefixIcon: Icon(
                      Icons.perm_identity,
                      size: 25,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  getTranslated(context, 'password'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: passwordController,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.secondary),
                  obscureText: showPassword,
                  decoration: InputDecoration(
                    hintText: getTranslated(context, 'password'),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(raduice))),
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 25,
                    ),
                    suffixIcon: IconButton(
                      icon: showPassword
                          ? Icon(Icons.remove_red_eye)
                          : Icon(Icons.visibility_off_outlined),
                      onPressed: () =>
                          setState(() => showPassword = !showPassword),
                    ),
                  ),
                ),

                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmailPage()));
                      },
                      child: Text(
                        getTranslated(context, 'forgot_password'),
                        style: TextStyle(
                          color:
                          Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 8,
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(raduice),
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                        if (_form.currentState!.validate())  {
                          UserCredential user =
                          (await _auth.signInWithEmailAndPassword(
                              email: usernameController.text,
                              password: passwordController.text));

                          User? userDetails = user.user;
                          print('userDetails $userDetails');
                          SharedPreferenceHelper().saveUserEmail(userDetails!.email??'');
                          SharedPreferenceHelper().saveUserId(userDetails.uid);
                          SharedPreferenceHelper()
                              .saveUserName(userDetails.displayName??'');
                          SharedPreferenceHelper().saveDisplayName(userDetails.displayName??'');
                          SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL??'');

                          if (isCompany) {
                            loginCompany(
                                usernameController.text,
                                passwordController.text,
                                user.user!.uid,
                                deviceToken)
                                .then((value) {
                              if (value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              }
                            });
                          } else {
                            loginUser(usernameController.text,
                                passwordController.text)
                                .then((value) {
                              if (value.id > -1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              }
                            });
                          }
                        }
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      getTranslated(context, 'login'),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                isCompany
                    ? Center()
                    : Column(
                  children: [
                    Center(
                      child: Text(
                        getTranslated(context, 'connect_with'),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: googleIcon,
                          iconSize: 50,
                          onPressed: () async {
                            AuthMethods().signInWithGoogle(context);
                          },
                        ),
                        IconButton(
                          icon:
                          facebookImage,
                          iconSize: 50,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getTranslated(context, 'you_do_not_have_account'),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                        fontSize: 16.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage(
                                  isCompany: isCompany,
                                )));
                      },
                      child: Text(getTranslated(context, 'sign_up'),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
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
