import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:o_travel/Models/category.dart';
import 'package:o_travel/Models/country.dart';
import 'package:o_travel/api/company/category_api.dart';
import 'package:o_travel/api/company/country_api.dart';
import 'package:o_travel/api/company/offer_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:select_dialog/select_dialog.dart';

class AddNewAdScreen extends StatefulWidget {
  const AddNewAdScreen({Key? key}) : super(key: key);

  @override
  _AddNewAdScreenState createState() => _AddNewAdScreenState();
}

class _AddNewAdScreenState extends State<AddNewAdScreen> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  File? image1, image2, image3;
  List<File> imageList = [];
  List<Category> categoryList = [];
  Category? selectedCategory;

  List<Country> countryList = [];
  List<Country> selectedCountries = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool isAr=false;

  getResources() {
    getLocale().then((locale) {
      setState(() {
        if (locale.languageCode == 'ar') this.isAr = true;else isAr=false;
      });
    });
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

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();


    getResources();
  }
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
  }
  Future pickImage(int index) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imgTemp = File(image.path);
    setState(() {
      if (index == 1) this.image1 = imgTemp;
      if (index == 2) this.image2 = imgTemp;
      if (index == 3) this.image3 = imgTemp;
    });
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  getTranslated(context, 'select_photo'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      child: (image1 == null)
                          ? Image.asset(
                              'assets/images/img_picker.png',
                              width: size.width * 0.3,
                              height: size.width * 0.3,
                              fit: BoxFit.cover,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                image1!,
                                width: size.width * 0.3,
                                height: size.width * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                      onTap: () {
                        pickImage(1);
                        print('image1');
                      },
                    ),
                    Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: (image2 == null)
                          ? Image.asset(
                              'assets/images/img_picker.png',
                              width: size.width * 0.3,
                              height: size.width * 0.3,
                              fit: BoxFit.cover,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                image2!,
                                width: size.width * 0.3,
                                height: size.width * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                      onTap: () {
                        pickImage(2);
                        print('image2');
                      },
                    ),
                    Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: (image3 == null)
                          ? Image.asset(
                              'assets/images/img_picker.png',
                              width: size.width * 0.3,
                              height: size.width * 0.3,
                              fit: BoxFit.cover,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                image3!,
                                width: size.width * 0.3,
                                height: size.width * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ),
                      onTap: () {
                        pickImage(3);
                        print('image3');
                      },
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  getTranslated(context, 'ad_name'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(),
                TextFormField(
                  controller: nameController,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.secondary),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: getTranslated(context, 'ad_name'),
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(raduice))),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  getTranslated(context, 'details'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(),
                TextFormField(
                  controller: descriptionController,
                  onChanged: (val) {
                    setState(() {});
                  },
                  keyboardType: TextInputType.multiline,
                  maxLength: 500,
                  minLines: 5,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(raduice))),
                  ),
                  style: TextStyle(
                    height: 1.6,
                    fontSize: 20,
                    decorationThickness: 0,
                  ), // when user presses enter it will adapt to it
                ),
                SizedBox(height: 16),
                Text(
                  getTranslated(context, 'country'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(),
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
                          title: Text(
                            isAr ? item.name_ar : item.name,
                            style: TextStyle(fontSize: 20),
                          ),
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
                    
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedCountries.length == 0
                                ? getTranslated(context, 'country')
                                : Country.getCountryNames(selectedCountries, isAr),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
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
                  height:16,
                ),
                Text(
                  getTranslated(context, 'month'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(),
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
                    
                    child: Align(
                      alignment:
                      isAr ? Alignment.centerRight : Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedDate == null
                                ? getTranslated(context, 'month')
                                : '${DateFormat.yMd().format(DateTime.parse(selectedDate.toString()))}',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
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
                  height:16,
                ),
                Text(
                  getTranslated(context, 'trip_type'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(),
                GestureDetector(
                  //trip_type
                  onTap: () {
                    SelectDialog.showModal<Category>(
                      context,
                      label: getTranslated(context, 'trip_type'),
                      items: categoryList,
                      selectedValue: selectedCategory,
                      showSearchBox: false,
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
                          title: Text(
                            isAr ? item.name_ar : item.name,
                            style: TextStyle(fontSize: 20),
                          ),
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
                    
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedCategory == null
                                ? getTranslated(context, 'trip_type')
                                : isAr ? selectedCategory!.name_ar : selectedCategory!.name,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
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
                  height:16,
                ),
                //----Price-------------------------------------
                Text(
                  getTranslated(context, 'price'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(),
                TextFormField(
                  controller: priceController,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.secondary),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: getTranslated(context, 'price'),
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(raduice))),
                  ),
                ),
                SizedBox(
                  height: 35,
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
                      if (image1 != null) imageList.add(image1!);
                      if (image2 != null) imageList.add(image2!);
                      if (image3 != null) imageList.add(image3!);
                      createOffer(
                          imageList,
                          nameController.text,
                          descriptionController.text,
                          priceController.text,
                          selectedCategory!.id,
                          selectedCountries,
                          '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',context);
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      getTranslated(context, 'save'),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
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
        getTranslated(context, 'add_new_ad'),
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
