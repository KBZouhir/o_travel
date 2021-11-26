import 'package:flutter/material.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/main.dart';
import 'package:o_travel/screens/auth/reset/email.dart';
import 'package:o_travel/screens/auth/sign_up_page.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/screens/localization/const.dart';

class LoginScreen extends StatefulWidget {
  final bool company;
  const LoginScreen({Key? key, required this.company}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = true;
  String _lang = 'en';
  @override
  void initState() {
    getLocale().then((locale) {
      setState(() {
        if(locale.languageCode=='en')this._lang='ar';
        else this._lang='en';
      });
    });
  }
  void _changeLanguage() async {
    Locale _locale = await setLocale(_lang);
    MyApp.setLocale(context, _locale);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
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
                  getTranslated(context, 'username')+' '+getTranslated(context, 'or')+' '+getTranslated(context, 'email'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: getTranslated(context, 'username')+' '+getTranslated(context, 'or')+' '+getTranslated(context, 'email'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(raduice))),
                    prefixIcon: Icon(
                      Icons.perm_identity,
                      size: 30,
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
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                  obscureText: showPassword,
                  decoration: InputDecoration(
                    hintText: getTranslated(context, 'password'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(raduice))),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmailPage()));
                      },
                      child: Text(
                        getTranslated(context, 'forgot_password'),
                        style: TextStyle(
                          color: Theme.of(context).accentColor.withOpacity(0.7),
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
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen())),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      getTranslated(context, 'login'),
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
                widget.company
                    ? Center()
                    : Column(
                        children: [
                          Center(
                            child: Text(
                              getTranslated(context, 'connect_with'),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).accentColor,
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
                                icon: Image.asset(
                                    'assets/images/google-plus.png'),
                                iconSize: 50,
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Image.asset('assets/images/facebook.png'),
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
                        color: Theme.of(context).accentColor.withOpacity(0.8),
                        fontSize: 16.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: Text(getTranslated(context, 'sign_up'),
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
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
