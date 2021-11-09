import 'package:flutter/material.dart';
import 'package:o_travel/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  double raduice=15.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 140,
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: Center(
              child: Text(
            'Create an account',
            style: TextStyle(fontSize: 25, color: Theme.of(context).primaryColor),
          )),
          leading: IconButton(
              icon: Icon(
                Icons.language_outlined,
                color: Colors.blueGrey,
                size: 30,
              ),
              onPressed: () {}),
          actions: [
            SizedBox(
              width: 55,
            )
          ],
          bottom: TabBar(
            unselectedLabelColor:Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(raduice), color:Theme.of(context).primaryColor),
            tabs: [
              Tab(
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Individuals",style: TextStyle(fontSize: 22),),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Companies",style: TextStyle(fontSize: 22)),
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
              'Username or email',
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
                hintText: 'Email Address',
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
              'Username or email',
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
                hintText: 'Email Address',
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
              'Password',
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
                hintText: 'Password',
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
              'Confirm password',
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
                hintText: 'Confirm password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(raduice))),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: showPassword
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
              'Phone number',
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
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'Phone number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(raduice))),
                prefixIcon: Icon(Icons.phone),
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
                  'Create account',
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
                  '''I have already an account ''',
                  style: TextStyle(
                    color: Theme.of(context).accentColor.withOpacity(0.5),
                    fontSize: 16.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('Sign Up');
                  },
                  child: Text('Login',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      )),
                )
              ],
            ),  SizedBox(
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
  bool showConfirmPassword = true;  double raduice=15.0;


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
              'Username or email',
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
                hintText: 'Email Address',
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
              'Username or email',
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
                hintText: 'Email Address',
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
              'Password',
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
                hintText: 'Password',
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
              'Confirm password',
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
                hintText: 'Confirm password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(raduice))),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: showPassword
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
              'Area',
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
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'Choose area',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(raduice))),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Phone number',
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
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'Phone number',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(raduice))),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Field',
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
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'Field',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(raduice))),

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
                  'Create account',
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
                  '''I have already an account ''',
                  style: TextStyle(
                    color: Theme.of(context).accentColor.withOpacity(0.5),
                    fontSize: 16.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('Sign Up');
                  },
                  child: Text('Login',
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
