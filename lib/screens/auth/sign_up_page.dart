import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:o_travel/Models/city.dart';
import 'package:o_travel/Models/domain.dart';
import 'package:o_travel/api/company/auth.dart';
import 'package:o_travel/api/company/city_api.dart';
import 'package:o_travel/api/company/domain_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/main.dart';
import 'package:o_travel/screens/auth/login_screen.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/screens/localization/const.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key,required this.isCompany}) : super(key: key);
 final bool isCompany;
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
      length: 2,initialIndex: widget.isCompany?1:0,
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
  late String  countryCode;
  late String  phone;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
              controller: usernameController,
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
              controller: emailController,
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
              controller: passwordController,
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
              controller: confirmPasswordController,
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
                  setState(() {
                    this.phone=phone.number!;
                  });
                },
                onCountryChanged: (dynamic phone) {
                  setState(() {
                    this.countryCode=phone.countryCode!;
                  });
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
                onPressed: (){
                  registerUser(usernameController.text, emailController.text, passwordController.text, confirmPasswordController.text, countryCode, phone, 'device_token').then((value){
                    if(value.id > -1){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }
                  });
                },
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen(company: false)));
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
  late String  countryCode;
  late String  phone;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  List<City> cityList = [];
  City? selectedCity;

  List<Domain> domainList = [];
  Domain? selectedDomain;

  getResources() {
    getAllDomain().then((value) {
      setState(() {
        domainList = value;
      });
    });

    getAllCity().then((value) {
      setState(() {
        cityList = value;
      });
    });
  }

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    getResources();
  }

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
              getTranslated(context, 'company_name'),
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: nameController,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  color: Theme.of(context).accentColor),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: getTranslated(context, 'company_name'),
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
              controller: emailController,
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
              controller: passwordController,
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
              controller: confirmPasswordController,
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
                 setState(() {
                   countryCode=phone.countryCode!;
                   this.phone=phone.number!;
                 });
                },
                onCountryChanged: (dynamic phone) {
                  setState(() {
                    countryCode=phone.countryCode!;
                    this.phone=phone.number!;
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
                  value: selectedCity,
                  padding: const EdgeInsets.all(15),
                  borderRadius: BorderRadius.circular(10),
                  border:  BorderSide(color: Theme.of(context).accentColor, width: 1),
                  dropdownButtonColor: Theme.of(context).backgroundColor,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCity = newValue as City?;
                    });
                  },
                  items: cityList
                      .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text(
                      value.name,
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
                  value: selectedDomain,
                  padding: const EdgeInsets.all(15),
                  borderRadius: BorderRadius.circular(10),
                  border:  BorderSide(color: Theme.of(context).accentColor, width: 1),
                  dropdownButtonColor: Theme.of(context).backgroundColor,
                  onChanged: (newValue) {
                    setState(() {
                      selectedDomain = newValue as Domain?;
                    });
                  },
                  items: domainList
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(
                              value.name,
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
                onPressed: (){
                  registerCompany(nameController.text, emailController.text, passwordController.text,
                      confirmPasswordController.text, countryCode, phone, selectedCity!.id, selectedDomain!.id, 'device_token');
                },
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen(company: true)));
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
