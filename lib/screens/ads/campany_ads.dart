import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:getwidget/getwidget.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/api/company/offer_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/ads/companyo_offer_widget.dart';
import 'package:o_travel/screens/home/components/ads_list.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/screens/localization/const.dart';

class CompanyAdsScreen extends StatefulWidget {
  const CompanyAdsScreen({Key? key}) : super(key: key);

  @override
  _CompanyAdsScreenState createState() => _CompanyAdsScreenState();
}

class _CompanyAdsScreenState extends State<CompanyAdsScreen> {
  List<Offer> offerList = [];
  bool loading = true;
  int offerPage = 1;
  bool hasNewData = true;
  ScrollController _scrollController=ScrollController();
  getResources() {
    getCompanyOffers(offerPage).then((value) {
      setState(() {
        offerList = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getResources();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print(_scrollController.position.pixels);

        getCompanyOffers(offerPage).then((value) {
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: buildAppBar(context),
        body: Builder(builder: (context) {
          if (offerList.length > 0) {
            return
                Container(
                    width: size.width,
                    height: size.height,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Builder(builder: (BuildContext context) {
                            if (offerList.length > 0)
                               return StaggeredGridView.countBuilder(
                              shrinkWrap: true,
                              crossAxisCount:4,
                              itemCount: offerList.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) =>
                                  Container( child: CompanyOfferWidget(offer: offerList[index])),
                              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                            );
                            else if (loading)
                              return Container(
                                height: 400,
                                child: GFLoader(),
                              );
                            else
                              return Container(
                                height: 400,
                                child: Center(
                                  child: Text(getTranslated(context, 'no_data')),
                                ),
                              );
                          }),
                          Container(
                            height: 100,
                            child: (hasNewData) ? GFLoader() : SizedBox(),
                          )
                        ],
                      ),
                    ));


          } else if (loading)
            return Container(
              height: 200,
              child: GFLoader(),
            );
          else {
            return Container(
                height: 60,
                child: Center(
                child: Text(getTranslated(
                context, 'no_data')),),
          );
          }
        }));
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
            getTranslated(context, 'added_ads'),
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


