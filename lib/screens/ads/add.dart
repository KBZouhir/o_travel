import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/localization/const.dart';

class AddNewAdScreen extends StatefulWidget {
  const AddNewAdScreen({Key? key}) : super(key: key);

  @override
  _AddNewAdScreenState createState() => _AddNewAdScreenState();
}

class _AddNewAdScreenState extends State<AddNewAdScreen> {
  File? image1, image2, image3;

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
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            height: 1300,
            padding: EdgeInsets.symmetric(horizontal: 16),
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
                TextField(
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
                  getTranslated(context, 'main_section'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(height: 8),
                TextFormField(
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText:'',
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(raduice))),
                  ),
                ),

                SizedBox(height: 16),
                Text(
                  getTranslated(context, 'country'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(height: 8),
                TextFormField(
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(raduice))),
                  ),
                ),

                SizedBox(height: 16),
                Text(
                  getTranslated(context, 'month'),
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                ),
                SizedBox(height: 8),
                TextFormField(
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(raduice))),
                  ),
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
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                      color: Theme.of(context).accentColor),
                  keyboardType: TextInputType.emailAddress,
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
                    onPressed: () {},
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
          child: Text(getTranslated(context, 'add_new_ad'),
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
