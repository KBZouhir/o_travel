import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:o_travel/Models/company.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/api/company/offer_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/companies/campany_profile_edit.dart';
import 'package:o_travel/screens/home/components/Ads_widget.dart';
import 'package:o_travel/screens/home/components/ads_list.dart';
import 'package:o_travel/screens/localization/const.dart';

class CompanyProfile extends StatefulWidget {
  final Company company;

  const CompanyProfile({Key? key, required this.company}) : super(key: key);

  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {

  List<Offer> offerList = [];


  getResources() {
    getAllOffers('company','${widget.company.id}').then((value) {
      setState(() {
        offerList = value;
      });
    });

  }

  @override
  void initState() {
    super.initState();
    getResources();
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
                height: 240,
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
                          widget.company.image,
                          height:100,
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
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(widget.company.name,
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),

                            ]))
                  ],
                )),
            Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.company.description??getTranslated(context, "lorem"),
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
                          widget.company.address,
                          softWrap: true,
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
                          widget.company.email,
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
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text(
                      getTranslated(context, 'phone'),
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                        ),
                        Spacer(),

                        Text(
                          widget.company.phone,
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
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       GestureDetector(
                       onTap: (){

                       },
                       child: Image.asset('assets/images/insta.png'),
                     ), GestureDetector(
                          onTap: () {},
                          child: Image.asset('assets/images/wtsp.png'),
                        ),
                        GestureDetector(
                         onTap: (){

                         },
                         child: Image.asset('assets/images/snap.png'),
                       ),

                       GestureDetector(
                         onTap: (){

                         },
                         child: Image.asset('assets/images/gmail.png'),
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
                      getTranslated(context,  "added_ads"),
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                    ),

                    OfferList(offerList:offerList),
                  ],
                )
            ),


          ],
        ),
      ),
    );
  }
}
