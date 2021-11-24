import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/home/components/Ads_widget.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/screens/localization/const.dart';

class FavoriesScreen extends StatefulWidget {
  const FavoriesScreen({Key? key}) : super(key: key);

  @override
  _FavoriesScreenState createState() => _FavoriesScreenState();
}

class _FavoriesScreenState extends State<FavoriesScreen> {
  List<String> list = [
    'listCat',
    'listCat',
    'listCat',
    'listCat',
  ];
  int i = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: buildAppBar( context),
      body: Builder(builder: (context){
        if(i==1){
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10,bottom: 60,right: 10,left: 10),
                width: size.width,
                height: size.height,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.1),
                  ),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return AdWidget(
                      full: false,
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Container(
                  width: double.infinity,
                  height:40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(raduice),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: (){
                      setState(() {
                        i=0;
                      });
                    },
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          getTranslated(context, 'delete_all')
                          ,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }else{
          return NoFavoritesWidget(size: size);
        }
      })
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
          child: Text(getTranslated(context, 'favorites'),
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
              getTranslated(context, 'no_favorites')
              ,
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              color: Theme.of(context).primaryColor,
              child: Text(
                getTranslated(context, 'go_home'),
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
