import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:o_travel/Models/category.dart';
import 'package:o_travel/Models/country.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/screens/profile/company/compay_profile.dart';
import 'package:o_travel/screens/home/components/Ads_widget.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowOffer extends StatefulWidget {
  final Offer offer;

  const ShowOffer({Key? key, required this.offer}) : super(key: key);

  @override
  _ShowOfferState createState() => _ShowOfferState();
}

class _ShowOfferState extends State<ShowOffer> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder: (_) =>
                            DetailImageScreen(widget.offer.images[0].url)),
                    child: Hero(
                      tag: 'offer${widget.offer.images[0].url}',
                      child: CachedNetworkImage(
                        imageUrl: widget.offer.images[0].url,
                        placeholder: (context, url) => Center(
                            child: Container(
                                width: 10,
                                height: 10,
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ))),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                        width: size.width,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
          if (!show)
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    show = true;
                  });
                },
                child: Container(
                  height: 50,
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Text(
                      getTranslated(context, 'more_details'),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            )
          else
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: size.height * 0.7,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: SingleChildScrollView(
                      padding: EdgeInsets.only(right: 20, left: 20),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                show = false;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: size.width,
                              child: Center(
                                child: Text(
                                  getTranslated(context, 'less_details'),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.offer.name,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(.8),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Text(
                                widget.offer.category.name,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.6),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Wrap(

                                  alignment: WrapAlignment.start,

                                  spacing: 5.0,

                                  direction: Axis.horizontal,

                                  children: buildTags(widget.offer.countries,context),

                                ),
                              ),
                              Text(
                                '${widget.offer.price}\$',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      border: Border.all(
                                          color: Colors.greenAccent
                                              .withOpacity(0.8),
                                          width: 3)),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        launch("tel://${widget.offer.company.phone}");

                                      },
                                      icon: Icon(
                                        Icons.phone_outlined,
                                        size: 35,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                  )),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      border: Border.all(
                                          color: Colors.blueAccent
                                              .withOpacity(0.8),
                                          width: 3)),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                      },
                                      icon: Icon(
                                        Icons.chat_outlined,
                                        size: 35,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    border: Border.all(
                                        color:
                                            Colors.redAccent.withOpacity(0.8),
                                        width: 3)),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite_border,
                                      size: 35,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(widget.offer.description,
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                getTranslated(context, 'publish_date') +
                                    '    ' +
                                    '${DateFormat.yMd().format(DateTime.parse(widget.offer.date.toString()))}',
                                style: TextStyle(
                                    fontSize: 14,
                                    height: 1.5,
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.6)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            height: 1,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.5),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            getTranslated(context, 'contact_company'),
                            style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.6)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                GestureDetector(
                                  onTap:(){
                                    Navigator.pop(context);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => CompanyProfile(company: widget.offer.company)));
                                  },
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              widget.offer.company.image,
                                          height: size.height * 0.13,
                                          width: size.height * 0.13,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                                  width: 50,
                                                  height: 50,
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ))),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text( widget.offer.company.name,
                                          style: TextStyle(
                                              fontSize: 25,
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Image.asset('assets/images/insta.png'),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Image.asset('assets/images/wtsp.png'),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Image.asset('assets/images/snap.png'),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Image.asset('assets/images/gmail.png'),
                                        ),
                                      ],
                                    ),
                                SizedBox(
                                  height: 50,
                                ),
                              ]))
                        ],
                      ))),
            ),
        ],
      ),
    );
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
        getTranslated(context, 'ad_details'),
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

  List<Widget> buildTags(List<Country> countries,context) {
    List<Widget> countryTags = <Widget>[];

    for(int i = 0; i < countries.length; i++) {

      countryTags.add(
        Chip(
          padding: EdgeInsets.all(5.0),
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),),
          shadowColor: Colors.grey.shade50,
          backgroundColor:  Theme.of(context).backgroundColor,

          label: Text(countries[i].name),



        ),
      );

    }

    return countryTags;

  }

}

class DetailImageScreen extends StatelessWidget {
  final String photo;

  DetailImageScreen(this.photo);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: PhotoView(imageProvider: NetworkImage(photo)));
  }
}
