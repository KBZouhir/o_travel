import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/screens/localization/const.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 1.3,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  child: Container(
                    height: 60,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor.withOpacity(0.05),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: TextField(
                        maxLines: 1,
                        style: TextStyle(fontSize: 20),
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).iconTheme.color,
                            size: 25,
                          ),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          fillColor:
                              Theme.of(context).backgroundColor.withOpacity(0),
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Search',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (bool == 1)
                  Container(
                    padding: EdgeInsets.all(10),
                    width: size.width,
                    height: size.height * 1.1,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor.withOpacity(0.05),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Campany ',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Theme.of(context).accentColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: EdgeInsets.all(10),
                    width: size.width,
                    height: size.height * 1.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        Center(
                          child: Image.asset(
                            'assets/images/noresult.png',
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.08,
                        ),
                        Center(
                          child: Text(
                            'No search results',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.08,
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(raduice),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            },
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Go back home',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ));
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
        getTranslated(context, 'search'),
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
