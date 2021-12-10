import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/Models/company.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/localization/const.dart';

class CompanyProfileEdit extends StatefulWidget {
  const CompanyProfileEdit({Key? key, required this.company}) : super(key: key);
final Company  company;
  @override
  _CompanyProfileEditState createState() => _CompanyProfileEditState();
}

class _CompanyProfileEditState extends State<CompanyProfileEdit> {


  TextEditingController usernameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController aboutController=TextEditingController();
  TextEditingController gpsController=TextEditingController();
  TextEditingController areaController=TextEditingController();
  TextEditingController fieldController=TextEditingController();
  TextEditingController commercialController=TextEditingController();
  TextEditingController snapController=TextEditingController();
  TextEditingController instaController=TextEditingController();

  @override
  void initState() {
    usernameController.text=widget.company.name;
    emailController.text=widget.company.email;
    phoneController.text=widget.company.phone;
    aboutController.text=widget.company.description;
    gpsController.text='${widget.company.latitude} ${widget.company.latitude}';
    areaController.text=widget.company.countryCode;
    snapController.text=widget.company.snapchat;
    instaController.text=widget.company.instagram;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),

        child: Column(
          children: [
            Container(
                padding:
                EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
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
                        Text(getTranslated(context, 'edit_profile'),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                        Spacer(),
                        SizedBox(width: 55)
                      ],
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl:widget.company.image,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(
                                  width: 50,
                                  height: 50,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                      ))),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
                padding: EdgeInsets.all(16),
                child :Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16
                    ),
                    Text(
                      getTranslated(context, 'company_name'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color:Theme.of(context).accentColor),
                    ),
                    SizedBox(
                      height: 8
                    ),
                    TextFormField(
                      controller: usernameController,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: getTranslated(context, 'company_name'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(raduice))),
                        prefixIcon: Icon(
                          Icons.perm_identity,
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16
                    ),
                    Text(
                      getTranslated(context, 'about_company'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                    ),
                    SizedBox(
                      height: 8
                    ),
                    TextField(
                      controller: aboutController,
                      onChanged: (val) {
                        setState(() {

                        });
                      },
                      keyboardType: TextInputType.multiline,
                      maxLength: 300,
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
                    SizedBox(
                      height: 16
                    ),
                    Text(
                      getTranslated(context, 'location_gps'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                    ),
                    SizedBox(
                      height: 8
                    ),
                    TextField(
                      controller: gpsController,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor,),
                      obscureText: false,

                      decoration: InputDecoration(
                        hintText: getTranslated(context, 'location_gps'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(raduice))),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                    ),
                    SizedBox(
                      height: 16
                    ),
                    Text(
                      getTranslated(context, 'email'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                    ),
                    SizedBox(
                      height: 8
                    ),
                    TextField(
                      controller: emailController,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText:getTranslated(context, 'email'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(raduice))),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),

                    SizedBox(
                      height: 16
                    ),
                    Text(
                      getTranslated(context, 'phone'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                    ),
                    SizedBox(
                      height: 8
                    ),
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
                            borderRadius: BorderRadius.all(Radius.circular(raduice))),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    SizedBox(
                      height: 16
                    ),
                    Text(
                      getTranslated(context, 'area'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                    ),
                    SizedBox(
                      height: 8
                    ),
                    TextField(
                      controller: areaController,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                      obscureText: false,
                      decoration: InputDecoration(

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(raduice))),

                      ),
                    ),
                    SizedBox(
                      height: 16
                    ),
                    Text(
                      getTranslated(context, 'field'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                    ),
                    SizedBox(
                      height: 8
                    ),
                    TextField(
                      controller:fieldController ,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                      obscureText: false,
                      decoration: InputDecoration(

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(raduice))),

                      ),
                    ),
                    SizedBox(
                      height: 16
                    ),
                    Text(
                      getTranslated(context, 'commercial_register'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                    ),
                    SizedBox(
                      height: 8
                    ),
                    TextField(
                      controller: commercialController,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.add_photo_alternate),
                        hintText: getTranslated(context, 'commercial_register'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(raduice))),

                      ),
                    ),
                    SizedBox(
                      height: 16
                    ),
                    Text(
                      getTranslated(context, 'snapchat'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                    ),
                    SizedBox(
                      height: 8
                    ),
                    TextField(
                      controller: snapController,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: getTranslated(context, 'snapchat'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(raduice))),

                      ),
                    ),
                    SizedBox(
                      height: 16
                    ),
                    Text(
                      getTranslated(context, 'instagram'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                    ),
                    SizedBox(
                      height: 8
                    ),
                    TextField(
                      controller:instaController,

                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).accentColor),
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: getTranslated(context, 'instagram'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(raduice))),

                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(raduice),
                      ),
                      child: MaterialButton(
                        onPressed: () => print("save"),
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
                )
                )

          ],
        ),
      ),
    );
  }
}
