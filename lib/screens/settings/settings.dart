import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/main.dart';
import 'package:o_travel/screens/localization/const.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDark = false;
  String _lang = 'en';
  @override
  // ignore: must_call_super
  void initState() {
    _isDark = MyApp.themeNotifier.value == ThemeMode.dark;
    getLocale().then((locale) {
     setState(() {
       if(locale.languageCode=='en')this._lang='ar';
       else this._lang='en';
     });
    });
  }
  void _changeLanguage(code) async {
    Locale _locale = await setLocale(code);
    MyApp.setLocale(context, _locale);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: Icon(Icons.language_outlined),
              title: Text(
                getTranslated(context,'language'),
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                _changeLanguage(this._lang);
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 1,
              color: Theme.of(context).accentColor.withOpacity(0.2),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title:  Text(
                getTranslated(context,'notification_settings'),

                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 1,
              color: Theme.of(context).accentColor.withOpacity(0.2),
            ),
            ListTile(
              leading: Icon(Icons.nightlight_round),
              title: Row(
                children: [
                  Text(
                    getTranslated(context,'night_mode'),
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  CupertinoSwitch(
                    value: _isDark,
                    onChanged: (value) {
                      setState(() {
                        _isDark = value;
                        MyApp.themeNotifier.value =
                        value ? ThemeMode.dark : ThemeMode.light;
                      });
                    },
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  _isDark = !_isDark;
                });
                MyApp.themeNotifier.value =
                MyApp.themeNotifier.value == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
              },
            ),
            Divider(
              height: 1,
              color: Theme.of(context).accentColor.withOpacity(0.2),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title:  Text(
                getTranslated(context,'logout'),

                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 1,
              color: Theme.of(context).accentColor.withOpacity(0.2),
            ),
            ListTile(
              leading: Icon(Icons.share),
              title:  Text(
                getTranslated(context,'share'),
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title:
              Center(child: Image.asset('assets/images/social_icons.png')),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
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
          child: Text(getTranslated(context, 'settings'),
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