import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDark = false;
  @override
  // ignore: must_call_super
  void initState() {
    _isDark = MyApp.themeNotifier.value == ThemeMode.dark;
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
              title: const Text(
                'Language',
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
              leading: Icon(Icons.notifications),
              title: const Text(
                'Notifications',
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
                    'Night Mode',
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
              title: const Text(
                'Sign out',
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
              title: const Text(
                'Share App',
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
          child: Text(
        'Settings',
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
