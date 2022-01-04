import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:o_travel/Models/city.dart';
import 'package:o_travel/Models/company.dart';
import 'package:o_travel/Models/domain.dart';
import 'package:o_travel/api/company/auth.dart';
import 'package:o_travel/api/company/city_api.dart';
import 'package:o_travel/api/company/domain_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/main.dart';
import 'package:o_travel/screens/auth/login_screen.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:o_travel/screens/term_of_use.dart';
import 'package:o_travel/services/auth.dart';
import 'package:select_dialog/select_dialog.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.isCompany}) : super(key: key);
  final bool isCompany;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _lang = 'en';
  bool isAr = false;
  bool checked = false;

  @override
  void initState() {
    super.initState();
    getLocale().then((locale) {
      setState(() {
        if (locale.languageCode == 'en') {
          this.isAr = false;
          this._lang = 'ar';
        } else {
          this.isAr = false;

          this._lang = 'en';
        }
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
      initialIndex: widget.isCompany ? 1 : 0,
      child: Scaffold(
        appBar: AppBar(
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
            CompanyPage(isAr: isAr),
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
  final _auth = FirebaseAuth.instance;

  bool showPassword = true;
  bool showConfirmPassword = true;
  late String countryCode;
  late String phone;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool checked = false;

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  getResources() {
    FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        deviceToken = value;
      });
    });
  }

  String? deviceToken = '';

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    getResources();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
            child: SingleChildScrollView(
                child: Container(
                    child:Form(
                      key: _form,
                      child:  Column(
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
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          SizedBox(),
                          TextFormField(
                            controller: usernameController,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                                color: Theme.of(context).colorScheme.secondary),
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
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          SizedBox(),
                          TextFormField(
                            controller: emailController,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                                color: Theme.of(context).colorScheme.secondary),
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
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          SizedBox(),
                          TextField(
                            controller: passwordController,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                                color: Theme.of(context).colorScheme.secondary),
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
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          SizedBox(),
                          TextField(
                            controller: confirmPasswordController,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                                color: Theme.of(context).colorScheme.secondary),
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
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          SizedBox(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).colorScheme.secondary),
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
                                setState(() {
                                  this.phone = phone.number!;
                                });
                              },
                              onCountryChanged: (dynamic phone) {
                                setState(() {
                                  this.countryCode = phone.countryCode!;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: this.checked,
                                onChanged: (value) {
                                  setState(() {
                                    this.checked = value!;
                                  });
                                },
                              ), //C
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TermOfUseScreen()));
                                },
                                child: Text(
                                  getTranslated(context, 'term_of_use'),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.7),
                                    fontSize: 18.0,
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
                                if (checked) {
                                  if (_form.currentState!.validate()) {
                                    registerUser(
                                        usernameController.text,
                                        emailController.text,
                                        passwordController.text,
                                        confirmPasswordController.text,
                                        countryCode,
                                        phone,
                                        deviceToken,
                                        '')
                                        .then((value) {
                                      if (value.id > -1) {
                                        AuthMethods().signUPWithEmailPassword(
                                            context,
                                            emailController.text,
                                            passwordController.text,
                                            usernameController.text,
                                            false);
                                      }
                                    });
                                  } else {}
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text(getTranslated(context, 'agree_term_of_use'),style: TextStyle(color: Colors.redAccent),),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              },
                              color: checked?Theme.of(context).primaryColor:Theme.of(context).primaryColor.withOpacity(0.3),
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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.5),
                                  fontSize: 16.0,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => LoginScreen()));
                                },
                                child: Text(getTranslated(context, 'login'),
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary,
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
                      ),
                    )))));
  }
}

class CompanyPage extends StatefulWidget {
  final bool isAr;

  const CompanyPage({Key? key, required this.isAr}) : super(key: key);

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  bool showPassword = true;
  bool showConfirmPassword = true;
  late String countryCode;
  late String phone;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool checked = false;

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  List<City> cityList = [];
  City? selectedCity;

  List<Domain> domainList = [];
  Domain? selectedDomain;
  DateTime? selectedDate;

  getResources() {
    getAllDomain().then((value) {
      setState(() {
        this.domainList = value;
      });
    });

    getAllCity().then((value) {
      setState(() {
        this.cityList = value;
      });
    });
    FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        deviceToken = value;
      });
    });
  }

  String? deviceToken = '';

  @override
  void initState() {
    super.initState();
    getResources();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
            child: SingleChildScrollView(
                child: Container(
                    child: Form(
                        key: _form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              getTranslated(context, 'company_name'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            SizedBox(),
                            TextFormField(
                              controller: nameController,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText:
                                    getTranslated(context, 'company_name'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(raduice))),
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
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            SizedBox(),
                            TextFormField(
                              controller: emailController,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: getTranslated(context, 'email'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(raduice))),
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
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            SizedBox(),
                            TextField(
                              controller: passwordController,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              obscureText: showPassword,
                              decoration: InputDecoration(
                                hintText: getTranslated(context, 'password'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(raduice))),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: showPassword
                                      ? Icon(Icons.remove_red_eye)
                                      : Icon(Icons.visibility_off_outlined),
                                  onPressed: () => setState(
                                      () => showPassword = !showPassword),
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
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            SizedBox(),
                            TextField(
                              controller: confirmPasswordController,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              obscureText: showConfirmPassword,
                              decoration: InputDecoration(
                                hintText:
                                    getTranslated(context, 'confirm_password'),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(raduice))),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: showConfirmPassword
                                      ? Icon(Icons.remove_red_eye)
                                      : Icon(Icons.visibility_off_outlined),
                                  onPressed: () => setState(() =>
                                      showConfirmPassword =
                                          !showConfirmPassword),
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
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            SizedBox(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(raduice))),
                              child: IntlPhoneField(
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: getTranslated(context, 'phone'),
                                    border: InputBorder.none,
                                    counterStyle: TextStyle(
                                      height: double.minPositive,
                                    ),
                                    counterText: "",
                                    contentPadding:
                                        EdgeInsets.only(bottom: 15)),
                                initialCountryCode: "DZ",
                                onChanged: (phone) {
                                  setState(() {
                                    countryCode = phone.countryCode!;
                                    this.phone = phone.number!;
                                  });
                                },
                                onCountryChanged: (dynamic phone) {
                                  setState(() {
                                    countryCode = phone.countryCode!;
                                    this.phone = phone.number!;
                                  });
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
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            GestureDetector(
                              onTap: () {
                                SelectDialog.showModal<City>(
                                  context,
                                  showSearchBox: false,
                                  label: getTranslated(context, 'area'),
                                  selectedValue: selectedCity,
                                  items: List.generate(cityList.length,
                                      (index) => cityList[index]),
                                  itemBuilder: (context, item, isSelected) {
                                    return ListTile(
                                      leading: isSelected
                                          ? Icon(
                                              Icons.circle,
                                              color: Colors.blue,
                                            )
                                          : Icon(
                                              Icons.circle,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                                  .withOpacity(.3),
                                            ),
                                      title: Text(
                                        widget.isAr ? item.name_ar : item.name,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      selected: isSelected,
                                    );
                                  },
                                  onChange: (City selected) {
                                    setState(() {
                                      selectedCity = selected;
                                    });
                                  },
                                  okButtonBuilder: (context, onPressed) {
                                    return Align(
                                      alignment: Alignment.centerRight,
                                      child: FloatingActionButton(
                                        onPressed: onPressed,
                                        child: Icon(Icons.check),
                                        mini: true,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Theme.of(context).backgroundColor,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedCity == null
                                            ? getTranslated(context, 'area')
                                            : widget.isAr
                                                ? selectedCity!.name_ar
                                                : selectedCity!.name,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        CupertinoIcons.chevron_down,
                                        size: 16,
                                      )
                                    ],
                                  ),
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
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            GestureDetector(
                              onTap: () {
                                SelectDialog.showModal<Domain>(
                                  context,
                                  showSearchBox: false,
                                  label: getTranslated(context, 'field'),
                                  selectedValue: selectedDomain,
                                  items: List.generate(domainList.length,
                                      (index) => domainList[index]),
                                  itemBuilder: (context, item, isSelected) {
                                    return ListTile(
                                      leading: isSelected
                                          ? Icon(
                                              Icons.circle,
                                              color: Colors.blue,
                                            )
                                          : Icon(
                                              Icons.circle,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                                  .withOpacity(.3),
                                            ),
                                      title: Text(
                                        item.name,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      selected: isSelected,
                                    );
                                  },
                                  onChange: (Domain selected) {
                                    setState(() {
                                      selectedDomain = selected;
                                    });
                                  },
                                  okButtonBuilder: (context, onPressed) {
                                    return Align(
                                      alignment: Alignment.centerRight,
                                      child: FloatingActionButton(
                                        onPressed: onPressed,
                                        child: Icon(Icons.check),
                                        mini: true,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Theme.of(context).backgroundColor,
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedDomain == null
                                            ? getTranslated(context, 'field')
                                            : selectedDomain!.name,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        CupertinoIcons.chevron_down,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: this.checked,
                                  onChanged: (value) {
                                    setState(() {
                                      this.checked = value!;
                                    });
                                  },
                                ), //C
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TermOfUseScreen()));
                                  },
                                  child: Text(
                                    getTranslated(context, 'term_of_use'),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.7),
                                      fontSize: 18.0,
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
                                  if (checked) {
                                    if (_form.currentState!.validate()) {
                                      Company val = await registerCompany(
                                          nameController.text,
                                          emailController.text,
                                          passwordController.text,
                                          confirmPasswordController.text,
                                          countryCode,
                                          phone,
                                          selectedCity!.id,
                                          selectedDomain!.id,
                                          deviceToken);
                                      if (val.id > -1) {
                                        AuthMethods().signUPWithEmailPassword(
                                            context,
                                            emailController.text,
                                            passwordController.text,
                                            nameController.text,
                                            true);
                                      }
                                    } else {}
                                  } else {
                                    final snackBar = SnackBar(
                                      content: Text(getTranslated(context, 'agree_term_of_use'),style: TextStyle(color: Colors.redAccent),),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                color: checked
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.3),
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.5),
                                    fontSize: 16.0,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  child: Text(getTranslated(context, 'login'),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
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
                        ))))));
  }
}
