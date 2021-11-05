import 'package:flutter/material.dart';
import 'package:o_travel/main.dart';
import 'package:o_travel/screens/auth/login_screen.dart';

class ChoosePage extends StatelessWidget {
  const ChoosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen(company: false)));
                  },
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),

                      padding: EdgeInsets.all(20),
                      height: 200,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Image.asset('assets/images/individuals.png'),
                      ),
                    ),SizedBox(
                      height: 20,
                    ),  Text(
                      'Individuals',
                      style: TextStyle(
                          fontSize: 35,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen(company: true)));
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          height: 200,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Center(
                            child: Image.asset('assets/images/companies.png'),
                          ),
                        ),SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Companies',
                          style: TextStyle(
                              fontSize:  35,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
