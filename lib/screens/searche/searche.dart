import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:o_travel/Models/category.dart';
import 'package:o_travel/Models/country.dart';
import 'package:o_travel/api/company/category_api.dart';
import 'package:o_travel/api/company/country_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:o_travel/screens/searche/result.dart';
import 'package:select_dialog/select_dialog.dart';

class SearchScreen extends StatefulWidget {
  final String search;

  const SearchScreen({Key? key, required this.search}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Category> categoryList = [];
  Category? selectedCategory;
  TextEditingController searchController = TextEditingController();
  List<Country> countryList = [];
  List<Country> selectedCountries = [];
  Country? selectedCountry;
  DateTime? selectedDate;

  getResources() {
    getAllCategory().then((value) {
      setState(() {
        categoryList = value;
      });
    });

    getAllCountry().then((value) {
      setState(() {
        countryList = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    searchController.text = widget.search;
    getResources();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  int val = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
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
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.05),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Center(
                    child: TextField(
                      controller: searchController,
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
                    color: Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(
                height: 2,
              ),
              GestureDetector(
                onTap: () {
                  SelectDialog.showModal<Country>(
                    context,
                    showSearchBox: false,
                    label: getTranslated(context, 'country'),
                    multipleSelectedValues: selectedCountries,
                    items: List.generate(
                        countryList.length, (index) => countryList[index]),
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
                        title: Text(item.name,style: TextStyle(fontSize: 20),),
                        selected: isSelected,
                      );
                    },
                    onMultipleItemsChange: (List<Country> selected) {
                      setState(() {
                        selectedCountries = selected;
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).backgroundColor,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary)),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedCountries.length==0
                              ? getTranslated(context, 'country')
                              : selectedCountries[0].name,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(CupertinoIcons.chevron_down,size: 16,)
                      ],
                    ),
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
                    color: Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(
                height: 2,
              ),
              GestureDetector(
                onTap: () {
                  showMonthPicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 1, 5),
                    lastDate: DateTime(DateTime.now().year + 1, 9),
                    initialDate: selectedDate ?? DateTime.now(),
                  ).then((date) {
                    if (date != null) {
                      setState(() {
                        selectedDate = date;
                      });
                    }
                  });
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).backgroundColor,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary)),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      selectedDate == null
                          ? getTranslated(context, 'month')
                          : '${DateFormat.yMd().format(DateTime.parse(selectedDate.toString()))}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
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
                    color: Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(
                height: 2,
              ),
              GestureDetector(
                //trip_type
                onTap: () {
                  SelectDialog.showModal<Category>(
                    context,
                    label: getTranslated(context, 'trip_type'),
                    items: categoryList,
                    selectedValue: selectedCategory,
                    itemBuilder:
                        (BuildContext context, Category item, bool isSelected) {
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
                        title: Text(item.name),
                        selected: isSelected,
                      );
                    },
                    onChange: (selected) {
                      setState(() {
                        selectedCategory = selected;
                      });
                    },
                  );
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).backgroundColor,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary)),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedCategory == null
                              ? getTranslated(context, 'trip_type')
                              : selectedCategory!.name,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(CupertinoIcons.chevron_down,size: 16,)
                      ],
                    ),
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
                    color: Theme.of(context).colorScheme.secondary),
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
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(getTranslated(context, 'default_order'),
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ))
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
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(getTranslated(context, 'by_latest'),
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ))
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
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(getTranslated(context, 'lowest_to_highest'),
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ))
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
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultScreen(
                              search: searchController.text,
                              category: selectedCategory != null
                                  ? selectedCategory!.id
                                  : -1,
                              month: selectedDate != null
                                  ? '${selectedDate!.year}-${selectedDate!.month}'
                                  : '',
                              country: selectedCountry != null
                                  ? selectedCountry!.id
                                  : -1))),
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
