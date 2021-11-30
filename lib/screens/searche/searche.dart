import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:o_travel/screens/searche/result.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? selectEvent="item1";
  List<String> listEvent = [
    'item1',
    'item2',
    'item3',
    'item4',
  ];
  bool _value = false;
  int val = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(context),
        body:SingleChildScrollView(
          child:  Container(
            color: Theme.of(context).backgroundColor,
            height: MediaQuery.of(context).size.height*1.3,
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
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          fillColor:
                          Theme.of(context).backgroundColor.withOpacity(0),
                          contentPadding: EdgeInsets.zero,
                          hintText: getTranslated(context, 'search'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  getTranslated(context, 'country'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).backgroundColor,
                  margin: EdgeInsets.symmetric(vertical: 10),
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
                  height: 10,
                ),
                Text(
                    getTranslated(context, 'month'),

                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).backgroundColor,
                  margin: EdgeInsets.symmetric(vertical: 10),
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
                  height: 10,
                ),
                Text(
                  getTranslated(context, 'trip_type'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).backgroundColor,
                  margin: EdgeInsets.symmetric(vertical: 10),
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
                  height: 10,
                ),
                Text(
                  getTranslated(context, 'price'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(
                  height: 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: val,
                          onChanged: (value) {
                            setState(() {
                              val = value as int;
                            });
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),SizedBox(width: 8,),
                        Text(
                            getTranslated(context, 'default_order'),
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).accentColor,
                            )
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: val,
                          onChanged: (value) {
                            setState(() {
                              val = value as int;
                            });
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),SizedBox(width: 8,),
                        Text(
                           getTranslated(context, 'by_latest'),
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).accentColor,
                            )
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 3,
                          groupValue: val,
                          onChanged: (value) {
                            setState(() {
                              val = value as int;
                            });
                          },
                          activeColor: Theme.of(context).primaryColor,
                        ),SizedBox(width: 8,),
                        Text(
                            getTranslated(context, 'lowest_to_highest') ,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).accentColor,
                            )
                        )
                      ],
                    ),

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(raduice),
                  ),
                  child: MaterialButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ResultScreen())),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      getTranslated(context, 'search'),
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
              ],
            ),
          ),
        ) );
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
          child: Text(getTranslated(context, 'search'),
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
