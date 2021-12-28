import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:o_travel/Models/category.dart';
import 'package:o_travel/Models/country.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/api/company/offer_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/home/components/ads_list.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/screens/localization/const.dart';

class ResultScreen extends StatefulWidget {
  final String search;
  final int category;
  final String month;
  final int country;

//featured:2
//search:offer one
//category:1
//country:2
//favorite:1
//month:2021-10
  const ResultScreen({
    Key? key,
    required this.search,
    required this.category,
    required this.month,
    required this.country,
  }) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Offer> offerList = [];
  int offerPage = 1;
  bool hasNewData = true;
  bool loading = true;
  String filter = '';
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
   if(widget.search.isNotEmpty)
     filter='&search=${widget.search}';
   if(widget.month.isNotEmpty)
     filter='&month=${widget.month}';
   if(widget.country!=-1)
     filter='&country=${widget.country}';
   if(widget.category!=-1)
     filter='&category=${widget.category}';


    fetchOffers(filter, offerPage).then((value) {
      setState(() {
        offerList = (value);
        loading = false;
        offerPage = 2;
      });
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print(_scrollController.position.pixels);

        fetchOffers(filter, offerPage).then((value) {
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
        getTranslated(context, 'search'),
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          controller: _scrollController,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all( 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(builder: (BuildContext context) {
                  if (offerList.length > 0)
                    return OfferList(offerList: offerList);
                  else if (loading)
                    return Container(
                      height: 400,
                      child: GFLoader(),
                    );
                  else
                    return Container(
                      padding: EdgeInsets.all(10),
                      width: size.width,
                      height: size.height ,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.1,
                            ),
                            Center(
                              child: Image.asset(
                                'assets/images/noresult.png',
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.08,
                            ),
                            Center(
                              child: Text(
                                getTranslated(context, 'no_result'),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.0,
                                    color: Theme.of(context).colorScheme.secondary),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.08,
                            ),
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(raduice),
                              ),

                            ),
                          ],
                        ),
                      ),
                    );
                }),
                Container(
                  height: 100,
                  child: (hasNewData && !loading) ? GFLoader() : SizedBox(),
                )
              ],
            ),

        ));
  }
}
