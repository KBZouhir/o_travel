import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/main.dart';
import 'package:o_travel/screens/localization/const.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _lang = 'en';

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 140,
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 3,
          title: Center(
              child: Text(
            getTranslated(context, 'create_account'),
            style:
                TextStyle(fontSize: 25, color: Theme.of(context).primaryColor),
          )),
          leading: IconButton(
              icon: Icon(
                Icons.language_outlined,
                color: Colors.blueGrey,
                size: 30,
              ),
              onPressed: () {
                _changeLanguage();
              }),
          actions: [
            SizedBox(
              width: 55,
            )
          ],
          bottom: TabBar(
            unselectedLabelColor: Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(raduice),
                color: Theme.of(context).primaryColor),
            tabs: [
              Tab(
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      getTranslated(context, 'individuals'),
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(getTranslated(context, 'companies'),
                        style: TextStyle(fontSize: 22)),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UserPage(),
            CompanyPage(),
          ],
        ),
      ),
    );
  }
}

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool showPassword = true;
  bool showConfirmPassword = true;

  String? selectEvent = "item1";
  List<String> listEvent = [
    'item1',
    'item2',
    'item3',
    'item4',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
            child: SingleChildScrollView(
                child: Container(
                    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              getTranslated(context, 'username'),
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
                hintText: getTranslated(context, 'username'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(raduice))),
                prefixIcon: Icon(
                  Icons.perm_identity,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              getTranslated(context, 'email'),
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
                hintText: getTranslated(context, 'email'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(raduice))),
                prefixIcon: Icon(
                  Icons.perm_identity,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              height: 16,
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
                  onPressed: () => setState(() => showPassword = !showPassword),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              getTranslated(context, 'confirm_password'),
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
              obscureText: showConfirmPassword,
              decoration: InputDecoration(
                hintText: getTranslated(context, 'confirm_password'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(raduice))),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: showConfirmPassword
                      ? Icon(Icons.remove_red_eye)
                      : Icon(Icons.visibility_off_outlined),
                  onPressed: () => setState(
                      () => showConfirmPassword = !showConfirmPassword),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              getTranslated(context, 'phone'),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).accentColor),
                  borderRadius: BorderRadius.all(Radius.circular(raduice))),
              child: IntlPhoneField(
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: getTranslated(context, 'phone'),
                    border: InputBorder.none,
                    counterStyle: TextStyle(
                      height: double.minPositive,
                    ),
                    counterText: "",
                    contentPadding: EdgeInsets.only(bottom: 15)),
                initialCountryCode: "DZ",
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
                onCountryChanged: (dynamic phone) {
                  print('Country code changed to: ' + phone.countryCode);
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(raduice),
              ),
              child: MaterialButton(
                onPressed: () => print("Create an account"),
                color: Theme.of(context).primaryColor,
                child: Text(
                  getTranslated(context, 'create_account'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getTranslated(context, 'i_have_account'),
                  style: TextStyle(
                    color: Theme.of(context).accentColor.withOpacity(0.5),
                    fontSize: 16.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('Sign Up');
                  },
                  child: Text(getTranslated(context, 'login'),
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        )))));
  }
}

class CompanyPage extends StatefulWidget {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  bool showPassword = true;
  bool showConfirmPassword = true;
  double raduice = 15.0;
  String? selectEvent = "item1";
  List<String> listEvent = [
    'item1',
    'item2',
    'item3',
    'item4',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
            child: SingleChildScrollView(
                child: Container(
                    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              getTranslated(context, 'username'),
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
                hintText: getTranslated(context, 'username'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(raduice))),
                prefixIcon: Icon(
                  Icons.perm_identity,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              getTranslated(context, 'email'),
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
                hintText: getTranslated(context, 'email'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(raduice))),
                prefixIcon: Icon(
                  Icons.perm_identity,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              height: 16,
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
                  onPressed: () => setState(() => showPassword = !showPassword),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              getTranslated(context, 'confirm_password'),
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
              obscureText: showConfirmPassword,
              decoration: InputDecoration(
                hintText: getTranslated(context, 'confirm_password'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(raduice))),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: showConfirmPassword
                      ? Icon(Icons.remove_red_eye)
                      : Icon(Icons.visibility_off_outlined),
                  onPressed: () => setState(
                      () => showConfirmPassword = !showConfirmPassword),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              getTranslated(context, 'phone'),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).accentColor),
                  borderRadius: BorderRadius.all(Radius.circular(raduice))),
              child: IntlPhoneField(
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: getTranslated(context, 'phone'),
                    border: InputBorder.none,
                    counterStyle: TextStyle(
                      height: double.minPositive,
                    ),
                    counterText: "",
                    contentPadding: EdgeInsets.only(bottom: 15)),
                initialCountryCode: "DZ",
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
                onCountryChanged: (dynamic phone) {
                  print('Country code changed to: ' + phone.countryCode);
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              getTranslated(context, 'area'),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).backgroundColor,
              child: DropdownButtonHideUnderline(
                child: GFDropdown(
                  value: selectEvent,
                  padding: const EdgeInsets.all(15),
                  borderRadius: BorderRadius.circular(10),
                  border:  BorderSide(color: Theme.of(context).accentColor, width: 1),
                  dropdownButtonColor: Theme.of(context).backgroundColor,
                  onChanged: (newValue) {
                    setState(() {
                      selectEvent = newValue as String;
                    });
                  },
                  items: listEvent
                      .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 18),
                    ),
                  ))
                      .toList(),
                ),
              ),
            ),

            SizedBox(
              height: 16,
            ),

            Text(
              getTranslated(context, 'field'),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).backgroundColor,
              child: DropdownButtonHideUnderline(
                child: GFDropdown(
                  value: selectEvent,
                  padding: const EdgeInsets.all(15),
                  borderRadius: BorderRadius.circular(10),
                  border:  BorderSide(color: Theme.of(context).accentColor, width: 1),
                  dropdownButtonColor: Theme.of(context).backgroundColor,
                  onChanged: (newValue) {
                    setState(() {
                      selectEvent = newValue as String;
                    });
                  },
                  items: listEvent
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 18),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(raduice),
              ),
              child: MaterialButton(
                onPressed: () => print("Create an account"),
                color: Theme.of(context).primaryColor,
                child: Text(
                  getTranslated(context, 'create_account'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  getTranslated(context, 'i_have_account'),
                  style: TextStyle(
                    color: Theme.of(context).accentColor.withOpacity(0.5),
                    fontSize: 16.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('Sign Up');
                  },
                  child: Text(getTranslated(context, 'login'),
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        )))));
  }
}
