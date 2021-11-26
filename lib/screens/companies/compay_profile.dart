import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/companies/campany_profile_edit.dart';
import 'package:o_travel/screens/home/components/Ads_widget.dart';
import 'package:o_travel/screens/localization/const.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({Key? key}) : super(key: key);

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding:
                EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
                height: 250,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(50)),
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
                        IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 25,
                            ),
                            onPressed: () =>    Navigator.push(context,
                                MaterialPageRoute(builder: (context) => CompanyProfileEdit()))),
                      ],
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl:
                          "https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png",
                          height: size.height * 0.12,
                          width: size.height * 0.12,
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
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Jannat Asia ',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Tourism\Sultanate of Oman',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300)),
                            ]))
                  ],
                )),
            Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated(context, 'lorem'),
                      style: TextStyle(fontSize: 16,height: 1.5),
                    ),
                    SizedBox(height: 16,),
                    Divider(
                      height: 1,
                      color: Theme
                          .of(context)
                          .accentColor
                          .withOpacity(0.2),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Text(
                          getTranslated(context, "area"),
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          '----',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Divider(
                      height: 1,
                      color: Theme
                          .of(context)
                          .accentColor
                          .withOpacity(0.2),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Text(
                          getTranslated(context, "email"),
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                        ),
                        Spacer(),

                        Text(
                          '----',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Divider(
                      height: 1,
                      color: Theme
                          .of(context)
                          .accentColor
                          .withOpacity(0.2),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Text(
                      getTranslated(context, 'phone'),
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                        ),
                        Spacer(),

                        Text(
                          '----',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Divider(
                      height: 1,
                      color: Theme
                          .of(context)
                          .accentColor
                          .withOpacity(0.2),
                    ),
                    SizedBox(height: 16,),

                    Text(
                      getTranslated(context, 'Social_Media_Accounts'),
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Social Media Accounts',
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 16,),
                    Divider(

                      height: 1,
                      color: Theme
                          .of(context)
                          .accentColor
                          .withOpacity(0.2),
                    ),
                    SizedBox(height: 16,),

                    Text(
                      getTranslated(context,  "added_ads"),
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 16,),

                    AdsContainer(),
                    AdsContainer(),
                    AdsContainer(),
                    AdsContainer(),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
