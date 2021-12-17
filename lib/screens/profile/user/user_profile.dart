import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:o_travel/Models/User.dart';
import 'package:o_travel/api/company/auth.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/localization/const.dart';

class UserProfile extends StatefulWidget {
  final User user;
  const UserProfile({Key? key, required this.user}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? image;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    usernameController.text = widget.user.name;
    emailController.text = widget.user.email;
    phoneController.text = widget.user.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
            height: 250,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(raduice)),
              color: primaryColorDark,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 25,
                        ),
                        onPressed: () => Navigator.pop(context)),
                    Spacer(),
                    Text(
                      getTranslated(context, 'profile'),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    SizedBox(width: 50)
                  ],
                ),
                SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child:(image==null)? CachedNetworkImage(
                        imageUrl: widget.user.image,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                            width: 50,
                            height: 50,
                            child: Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ))),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                      ):Image.file(image!,height: 100,
                        width: 100,),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(widget.user.name,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    getTranslated(context, 'username'),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: Theme.of(context).accentColor),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: usernameController,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: Theme.of(context).accentColor),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: getTranslated(context, 'username'),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(raduice))),
                      prefixIcon: Icon(
                        Icons.perm_identity,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    getTranslated(context, 'email'),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: Theme.of(context).accentColor),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: Theme.of(context).accentColor),
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: getTranslated(context, 'email'),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(raduice))),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    getTranslated(context, 'phone'),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: Theme.of(context).accentColor),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: phoneController,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: Theme.of(context).accentColor),
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: getTranslated(context, 'phone'),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(raduice))),
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(raduice),
                    ),
                    child: MaterialButton(
                      onPressed: (){
                        updateUser(usernameController.text,emailController.text,phoneController.text);
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
                    height: 30,
                  ),
                ],
              ))
        ]),
      ),
    );
  }
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imgTemp = File(image.path);
    setState(() {
        this.image = imgTemp;
        updateImg(imgTemp);
    });

  }

}
