import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';

class SearcheScreen extends StatefulWidget {
  const SearcheScreen({Key? key}) : super(key: key);

  @override
  _SearcheScreenState createState() => _SearcheScreenState();
}

class _SearcheScreenState extends State<SearcheScreen> {
  String? selectEvent;
  List<String> listEvent = ['listCat','listCat','listCat','listCat',];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter GridView Demo"),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
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
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: DropdownButtonHideUnderline(
                  child: GFDropdown(
                    value: selectEvent,
                    padding: const EdgeInsets.all(15),
                    borderRadius: BorderRadius.circular(10),
                    border: const BorderSide(
                        color: Colors.black12, width: 1),
                    dropdownButtonColor: Colors.white,
                    onChanged: (newValue) {
                      setState(() {
                        selectEvent = 'newValue as Event?';
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
              SizedBox(height: 20,),
              SizedBox(height: 20,),
            ],
          ),
        ));
  }
}
