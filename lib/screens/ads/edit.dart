import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:o_travel/Models/category.dart';
import 'package:o_travel/Models/country.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/api/company/category_api.dart';
import 'package:o_travel/api/company/country_api.dart';
import 'package:o_travel/api/company/offer_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/localization/const.dart';

class EditAdScreen extends StatefulWidget {
  final Offer offer;

  const EditAdScreen({Key? key,required this.offer}) : super(key: key);

  @override
  _EditAdScreenState createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  File? image1, image2, image3;
  List<File> imageList = [];
  List<Category> categoryList = [];
  Category? selectedCategory;

  List<Country> countryList = [];
  Country? selectedCountry;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

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

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    getResources();
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
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
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
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: nameController,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
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
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: descriptionController,

                  onChanged: (val) {
                    setState(() {});
                  },
                  keyboardType: TextInputType.multiline,
                  maxLength: 500,
                  minLines: 10,
                  maxLines: 10,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(raduice))),
                  ),
                  style: TextStyle(
                    height: 1.6,
                    fontSize: 16,
                    decorationThickness: 0,
                  ), // when user presses enter it will adapt to it
                ),
                SizedBox(height: 16),
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
                      hint: Text(getTranslated(context, 'country')),
                      value: selectedCountry,
                      padding: const EdgeInsets.all(15),
                      borderRadius: BorderRadius.circular(10),
                      border: BorderSide(
                          color: Theme.of(context).accentColor, width: 1),
                      dropdownButtonColor: Theme.of(context).backgroundColor,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCountry = newValue as Country?;
                        });
                      },
                      items: countryList
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
                        border:
                        Border.all(color: Theme.of(context).accentColor)),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        selectedDate == null
                            ? getTranslated(context, 'month')
                            : '${DateFormat.yMd().format(DateTime.parse(selectedDate.toString()))}',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 18,
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
                      hint: Text(getTranslated(context, 'trip_type')),
                      value: selectedCategory,
                      padding: const EdgeInsets.all(15),
                      borderRadius: BorderRadius.circular(10),
                      border: BorderSide(
                          color: Theme.of(context).accentColor, width: 1),
                      dropdownButtonColor: Theme.of(context).backgroundColor,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCategory = newValue as Category?;
                        });
                      },
                      items: categoryList
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
                  height: 10,
                ),
                SizedBox(height: 16),

                //----Price-------------------------------------
                Text(
                  getTranslated(context, 'price'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: priceController,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
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
                          selectedCountry!.id,
                          '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}');
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      getTranslated(context, 'save'),
                      style: TextStyle(
                        fontSize: 18,
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
