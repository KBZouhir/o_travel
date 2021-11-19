import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/home/home.dart';

class FavoriesScreen extends StatefulWidget {
  const FavoriesScreen({Key? key}) : super(key: key);

  @override
  _FavoriesScreenState createState() => _FavoriesScreenState();
}

class _FavoriesScreenState extends State<FavoriesScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int i = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Favories"),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 1.3,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Builder(
              builder: (context) {
                if (bool == 1)
                  return Container(
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
                  );
                else
                  return NoFavoritesWidget(size: size);
              },
            )),
      ),
    );
  }
}

class NoFavoritesWidget extends StatelessWidget {
  const NoFavoritesWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: size.width,
      height: size.height * 1.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Center(
            child: Image.asset(
              'assets/images/nofavories.png',
            ),
          ),
          SizedBox(
            height: size.height * 0.08,
          ),
          Center(
            child: Text(
              'No Favoriess',
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
    );
  }
}
