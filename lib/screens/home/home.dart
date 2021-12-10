import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:o_travel/Models/category.dart';
import 'package:o_travel/Models/country.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/Models/story.dart';
import 'package:o_travel/Models/type.dart';
import 'package:o_travel/api/company/auth.dart';
import 'package:o_travel/api/company/offer_api.dart';
import 'package:o_travel/api/company/story_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/about.dart';
import 'package:o_travel/screens/ads/add.dart';
import 'package:o_travel/screens/chat/chat_page.dart';
import 'package:o_travel/screens/companies/companies_guide.dart';
import 'package:o_travel/screens/home/components/drawer.dart';
import 'package:o_travel/screens/home/components/stories.dart';
import 'package:o_travel/screens/profile/company/compay_profile.dart';
import 'package:o_travel/screens/profile/company/show_company_profile.dart';
import 'package:o_travel/screens/contact.dart';
import 'package:o_travel/screens/favorites/favories.dart';
import 'package:o_travel/screens/home/components/Ads_widget.dart';
import 'package:o_travel/screens/home/components/carousel_widget.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:o_travel/screens/notifications/notification.dart';
import 'package:o_travel/screens/profile/user/user_profile.dart';
import 'package:o_travel/screens/searche/searche.dart';
import 'package:o_travel/screens/settings/settings.dart';
import 'package:photo_view/photo_view.dart';

import 'components/ads_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  DateTime? selectedDate;
  ScrollController _scrollController = new ScrollController();
  bool loadingOffer = true;
  bool loadingFeatured = true;
  bool loadingStory = true;
  bool isCompany = false;
  List<Offer> offerList = [];
  List<Offer> featuredOfferList = [];
  List<Category> categoryList = [];
  Category? selectedCategory;
  dynamic me;
  List<Country> countryList = [];
  Country? selectedCountry;
  List<Story> storyList = [];

  getResources() {
    /*getAllCategory().then((value) {
      setState(() {
        categoryList = value;
      });
    });

    getAllCountry().then((value) {
      setState(() {
        countryList = value;
      });
    });*/

    UserType.getType().then((value) {
      setState(() {
        this.isCompany = value;
      });
      if (value)
        getCompany().then((value) {
          setState(() {
            me = value;
            print('$me');
          });
        });
      else
        getUser().then((value) {
          setState(() {
            me = value;
            print('$me');
          });
        });
    });

    getAllOffers('featured', '1').then((value) {
      setState(() {
        offerList = (value);
        loadingFeatured = false;
      });
    });
    getAllOffers('featured', '2').then((value) {
      setState(() {
        featuredOfferList = (value);
        loadingFeatured = false;
        print('featuredOfferList $featuredOfferList');
      });
    });

    getAllStory().then((value) {
      setState(() {
        storyList = value;
        loadingStory = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getResources();
    /*  _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getAllOffers('featured', '1').then((value) {
          setState(() {
            offerList.addAll(value);
          });
        });
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: MyDrawer(me: me, isCompany: isCompany),
        appBar: buildAppBar(context),
        body: Container(
            width: size.width,
            height: size.height,
            color: Theme.of(context).backgroundColor,
            child: Stack(
              children: [
                RefreshIndicator(
                  color: Theme.of(context).primaryColor,
                  key: _refreshIndicatorKey,
                  onRefresh: _refresh,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Builder(builder: (BuildContext context) {
                          return Container(
                              height: 50,
                              child: Row(children: [
                                (isCompany)
                                    ? GestureDetector(
                                  onTap: (){
                                    pickImage();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 15),
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                            width: 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: Center(
                                      child: Icon(Icons.add,
                                          size: 30,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.4)),
                                    ),
                                  ),
                                )
                                    : SizedBox(),
                                Expanded(
                                    child: (storyList.length > 0)
                                        ? StoriesList(storyList: storyList)
                                        : (loadingStory)
                                            ? Container(
                                                height: 60,
                                                child: GFLoader(),
                                              )
                                            : Container(
                                                height: 60,
                                                child: Center(
                                                  child: Text(getTranslated(
                                                      context, 'no_data')),
                                                ),
                                              ))
                              ]));
                        }),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 3,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.05),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SearchWidget(size: size),
                        SizedBox(
                          height: 20,
                        ),
                        Builder(builder: (BuildContext context) {
                          if (featuredOfferList.length > 0)
                            return CarouselWidget(offerList: featuredOfferList);
                          else if (loadingFeatured)
                            return Container(
                              height: 200,
                              child: GFLoader(),
                            );
                          else
                            return Container(
                              height: 200,
                              child: Center(
                                child: Text(getTranslated(context, 'no_data')),
                              ),
                            );
                        }),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 50,
                              width: size.width * 0.29,
                              constraints: BoxConstraints(
                                maxWidth: size.width * 0.29,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: GFDropdown(
                                  hint: Text(
                                    getTranslated(context, 'trip_type'),
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  value: selectedCategory,
                                  padding: const EdgeInsets.all(15),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  dropdownButtonColor: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.05),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCategory = newValue as Category?;
                                    });
                                  },
                                  items: categoryList
                                      .map((value) => DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                              value.name,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: size.width * 0.29,
                              constraints: BoxConstraints(
                                maxWidth: size.width * 0.29,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: GFDropdown(
                                  hint: Text(getTranslated(context, 'country'),
                                      style: TextStyle(fontSize: 16)),
                                  value: selectedCountry,
                                  padding: const EdgeInsets.all(15),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  dropdownButtonColor: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.05),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCountry = newValue as Country?;
                                    });
                                  },
                                  items: countryList
                                      .map((value) => DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                              value.name,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: size.width * 0.29,
                              constraints: BoxConstraints(
                                maxWidth: size.width * 0.29,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  showMonthPicker(
                                    context: context,
                                    firstDate:
                                        DateTime(DateTime.now().year - 1, 5),
                                    lastDate:
                                        DateTime(DateTime.now().year + 1, 9),
                                    initialDate: selectedDate ?? DateTime.now(),
                                  ).then((date) {
                                    if (date != null) {
                                      setState(() {
                                        selectedDate = date;
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.05),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      selectedDate == null
                                          ? getTranslated(context, 'month')
                                          : '${DateFormat.yMd().format(DateTime.parse(selectedDate.toString()))}',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Builder(builder: (BuildContext context) {
                          if (offerList.length > 0)
                            return StaggeredGridView.countBuilder(
                              shrinkWrap: true,
                              crossAxisCount: 4,
                              itemCount: offerList.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) =>
                                  Container(
                                      child:
                                          OfferWidget(offer: offerList[index])),
                              staggeredTileBuilder: (int index) =>
                                  new StaggeredTile.fit(2),
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                            );
                          else if (loadingFeatured)
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
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                ),
                isCompany
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(raduice),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddNewAdScreen()));
                            },
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              getTranslated(context, 'add_new_ad'),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            )));
  }
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imgTemp = File(image.path);
    showDialog(context: context, builder: (_) => AddStory(image:imgTemp));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme,
      toolbarHeight: 60,
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      title: Center(
          child: Text(
        'Otravel',
        style: TextStyle(
            fontSize: 30,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold),
      )),
      actions: [
        SizedBox(
          width: 55,
        )
      ],
    );
  }

  Future<void> _refresh() async {
    setState(() {
      loadingOffer = true;
      loadingFeatured = true;
      loadingStory = true;
      getResources();
    });
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: size.width * 0.6,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.05),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Center(
            child: TextField(
              maxLines: 1,
              style: TextStyle(fontSize: 22),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).iconTheme.color,
                  size: 25,
                ),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                fillColor: Theme.of(context).backgroundColor.withOpacity(0),
                contentPadding: EdgeInsets.zero,
                hintText: getTranslated(context, 'search'),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          height: 50,
          width: size.width * 0.12,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.05),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.filter_list_alt,
                size: 25,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CompaniesGuideScreen()));
          },
          child: Container(
            height: 50,
            width: size.width * 0.2,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor.withOpacity(0.05),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Center(
              child: Text(
                getTranslated(context, 'guide'),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

