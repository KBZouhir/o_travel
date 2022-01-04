import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:o_travel/Models/company.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/api/company/offer_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/ads/add.dart';
import 'package:o_travel/screens/ads/campany_ads.dart';
import 'package:o_travel/screens/ads/show.dart';
import 'package:o_travel/screens/profile/company/campany_profile_edit.dart';
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
  bool loading = true;

  getResources() {
    getAllOffers('company', '${widget.company.id}', offerPage).then((value) {
      setState(() {
        offerList = value;
        offerPage = offerPage + 1;
      });
    });
  }

  int offerPage = 1;
  bool hasNewData = true;
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    getResources();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print(_scrollController.position.pixels);

        fetchOffers('company=${widget.company.id}', offerPage).then((value) {
          setState(() {
            if (value.length == 0)
              hasNewData = false;
            else
              offerPage = offerPage + 1;

            offerList.addAll(value);
          });
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,

      body: SingleChildScrollView(
        controller: _scrollController,
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
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CompanyProfileEdit(
                                        company: widget.company)))),
                      ],
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Hero(
                          tag: 'company_img_${widget.company.id}',
                          child: CachedNetworkImage(
                            imageUrl: widget.company.image,
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
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(widget.company.name,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                )),
            Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddNewAdScreen()));
                        },
                        
                        child:Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryColorLite,
                            border: Border.all(color: Theme.of(context).primaryColor, )
                              ,borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          child: Center(
                            child: Text(
                                getTranslated(context, 'add_new_ad'),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ) 
                        ),
                    ),
                    
                    Text(
                      widget.company.description,
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text(
                          getTranslated(context, "area"),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          widget.company.address,
                          softWrap: true,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text(
                          getTranslated(context, "email"),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          widget.company.email,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text(
                          getTranslated(context, 'phone'),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          widget.company.phone,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text(
                          getTranslated(context, 'added_ads'),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        TextButton(onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => CompanyAdsScreen()));
                        }, child:   Text(
                          getTranslated(context, 'edit'),
                          style: TextStyle(fontSize: 16),
                        ),)

                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text(
                          getTranslated(context, 'commercial_register'),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        IconButton(onPressed: (){
                          showDialog(
                              context: context,
                              builder: (_) => DetailImageScreen(
                                  widget.company.trade_register));
                        }, icon: Icon(Icons.photo))
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      getTranslated(context, 'Social_Media_Accounts'),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    (widget.company.social_media_visible)
                        ?  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: instagramImage),
                        SizedBox(width: 20,),
                        GestureDetector(
                          onTap: () {},
                          child: whatsappImage,
                        ),
                        SizedBox(width: 20,),

                        GestureDetector(
                          onTap: () {},
                          child: snapImage,
                        ),
                        SizedBox(width: 20,),

                        GestureDetector(
                          onTap: () {},
                          child:gmailImage,
                        ),
                      ],
                    )
                        : SizedBox(),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    ),
                    SizedBox(
                      height: 16,
                    ),

                  ],
                )),
          ],
        ),
      ),
    );
  }
}
