import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:o_travel/Models/country.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/api/company/offer_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/home/components/ads_list.dart';
import 'package:o_travel/screens/profile/company/compay_profile.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:o_travel/screens/profile/company/show_company_profile.dart';
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
  List<Offer> offerList = [];
  bool isAr=false;

  getResources() {
    getLocale().then((locale) {
      setState(() {
        if (locale.languageCode == 'ar') this.isAr = true;else isAr=false;
      });
    });
    getAllOffers('company', '${widget.offer.company.id}', offerPage)
        .then((value) {
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

        getAllOffers('company', '${widget.offer.company.id}', offerPage)
            .then((value) {
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

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }

      return result;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.bounceIn,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              items: widget.offer.images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => DetailImageScreen(i.url));
                          },
                          child: Hero(
                            tag: 'offer${i.id}',
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              child: CachedNetworkImage(
                                imageUrl: i.url,
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
                        ));
                  },
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(
                widget.offer.images,
                (index, url) {
                  return Container(
                    width: _current == index ? 20 : 8,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(horizontal: 2, vertical: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: _current == index
                            ? Colors.black
                            : primaryColorLite),
                  );
                },
              ),
            ),
            Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.offer.name,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(.8),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Text(
                          isAr?widget.offer.category.name_ar:widget.offer.category.name,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
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
                            children:
                                buildTags(widget.offer.countries,isAr ,context),
                          ),
                        ),
                        Text(
                          '${widget.offer.price}\$',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                border: Border.all(
                                    color: Colors.greenAccent.withOpacity(0.8),
                                    width: 3)),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  launch("tel://${widget.offer.company.phone}");
                                },
                                icon: Icon(
                                  Icons.phone_outlined,
                                  size: 35,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            )),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                border: Border.all(
                                    color: Colors.blueAccent.withOpacity(0.8),
                                    width: 3)),
                            child: Center(
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.chat_outlined,
                                  size: 35,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            )),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              border: Border.all(
                                  color: Colors.redAccent.withOpacity(0.8),
                                  width: 3)),
                          child: Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite_border,
                                size: 35,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.offer.description,
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
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.6)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.5),
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
                              .colorScheme
                              .secondary
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
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowCompanyProfile(
                                          company: widget.offer.company)));
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.offer.company.image,
                                    height: 80,
                                    width: 80,
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
                                SizedBox(
                                  height: 10,
                                ),
                                Text(widget.offer.company.name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          (widget.offer.company.social_media_visible)
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
                            height: 20,
                          ),
                          Text(
                            getTranslated(context, "added_ads"),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          OfferList(offerList: offerList),
                          Container(
                            height: 100,
                            child: (hasNewData) ? GFLoader() : SizedBox(),
                          )
                        ]))
                  ],
                )),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme,
      toolbarHeight: 50,
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 2,
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

  List<Widget> buildTags(List<Country> countries,isAr, context) {
    List<Widget> countryTags = <Widget>[];

    for (int i = 0; i < countries.length; i++) {
      countryTags.add(
        Chip(
          padding: EdgeInsets.all(5.0),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.grey.shade50,
          backgroundColor: gray228,
          label: Text(isAr?countries[i].name_ar:countries[i].name),
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
    if (photo.isEmpty) Navigator.pop(context);
    return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: PhotoView(imageProvider: NetworkImage(photo)));
  }
}
