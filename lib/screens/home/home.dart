import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:o_travel/Models/StoriesCompany.dart';
import 'package:o_travel/Models/category.dart';
import 'package:o_travel/Models/country.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/Models/story.dart';
import 'package:o_travel/Models/type.dart';
import 'package:o_travel/api/company/auth.dart';
import 'package:o_travel/api/company/category_api.dart';
import 'package:o_travel/api/company/country_api.dart';
import 'package:o_travel/api/company/offer_api.dart';
import 'package:o_travel/api/company/story_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/ads/add.dart';
import 'package:o_travel/screens/companies_guide.dart';
import 'package:o_travel/screens/home/components/drawer.dart';
import 'package:o_travel/screens/home/components/stories.dart';
import 'package:o_travel/screens/home/components/carousel_widget.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:o_travel/screens/searche/searche.dart';
import 'package:select_dialog/select_dialog.dart';

import 'components/ads_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static void setStories(BuildContext context) {
    _HomeScreenState? state =
        context.findAncestorStateOfType<_HomeScreenState>();
    state!.getStories();
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  DateTime? selectedDate;
  bool loadingOffer = true;
  bool loadingFeatured = true;
  bool loadingStory = true;
  bool isCompany = false;
  int offerPage = 1;
  bool hasNewData = true;
  ScrollController _scrollController = new ScrollController();

  List<Offer> offerList = [];
  List<Offer> featuredOfferList = [];
  List<Category> categoryList = [];
  Category? selectedCategory;
  dynamic me;
  List<Country> countryList = [];
  Country? selectedCountry;
  List<StoryCompany> storyList = [];

  getStories() {
    getAllStoryCompany().then((value) {
      setState(() {
        storyList = value;
        loadingStory = false;
      });
    });
  }

  getResources() {
    getAllCategory().then((value) {
      setState(() {
        categoryList = value;
      });
    });

    getAllCountry().then((value) {
      setState(() {
        countryList = value;
      });
    });

    UserType.getType().then((value) {
      setState(() {
        this.isCompany = value;
      });
      if (value)
        getCompany().then((value) {
          setState(() {
            me = value;
            //  print('$me');
          });
        });
      else
        getUser().then((value) {
          setState(() {
            me = value;
            //     print('$me');
          });
        });
    });

    getAllOffers('featured', '1', offerPage).then((value) {
      setState(() {
        offerList = (value);
        loadingFeatured = false;
        offerPage = 2;
      });
    });
    getAllOffers('featured', '2', offerPage).then((value) {
      setState(() {
        featuredOfferList = (value);
        loadingFeatured = false;
        //print('featuredOfferList $featuredOfferList');
      });
    });

    getAllStoryCompany().then((value) {
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
    if (EasyLoading.isShow) EasyLoading.dismiss();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // print(_scrollController.position.pixels);

        getAllOffers('featured', '1', offerPage).then((value) {
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
        drawer: MyDrawer(me: me, isCompany: isCompany),
        appBar: buildAppBar(context),
        body: SafeArea(
          child: Container(
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
                      controller: _scrollController,
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
                                          onTap: () {
                                            pickImage()
                                                .then((value) => _refresh());
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
                                          ? StoriesList(storyList: storyList,id:me.id,isCompany:isCompany)
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
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.05),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SearchWidget(),
                          SizedBox(
                            height: 20,
                          ),
                          Builder(builder: (BuildContext context) {
                            if (featuredOfferList.length > 0)
                              return CarouselWidget(
                                  offerList: featuredOfferList);
                            else if (loadingFeatured)
                              return Container(
                                height: 200,
                                child: GFLoader(),
                              );
                            else
                              return Container(
                                height: 200,
                                child: Center(
                                  child:
                                      Text(getTranslated(context, 'no_data')),
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
                                height: 70,
                                width: size.width * 0.29,
                                constraints: BoxConstraints(
                                  maxWidth: size.width * 0.29,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    SelectDialog.showModal<Country>(
                                      context,
                                      showSearchBox: false,
                                      label: getTranslated(context, 'country'),
                                      selectedValue: selectedCountry,
                                      items: List.generate(countryList.length,
                                          (index) => countryList[index]),
                                      itemBuilder: (context, item, isSelected) {
                                        return ListTile(
                                          leading: isSelected
                                              ? Icon(
                                                  Icons.circle,
                                                  color: Colors.blue,
                                                )
                                              : Icon(
                                                  Icons.circle,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                      .withOpacity(.3),
                                                ),
                                          title: Text(
                                            item.name,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          selected: isSelected,
                                        );
                                      },
                                      onChange: (Country selected) {
                                        setState(() {
                                          selectedCountry = selected;
                                        });
                                      },
                                      okButtonBuilder: (context, onPressed) {
                                        return Align(
                                          alignment: Alignment.centerRight,
                                          child: FloatingActionButton(
                                            onPressed: onPressed,
                                            child: Icon(Icons.check),
                                            mini: true,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.05),
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedCountry == null
                                                ? getTranslated(
                                                    context, 'country')
                                                : selectedCountry!
                                                .name.length >
                                                8
                                                ? selectedCountry!.name
                                                .substring(0, 7)
                                                : selectedCountry!.name,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            CupertinoIcons.chevron_down,
                                            size: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 70,
                                width: size.width * 0.29,
                                constraints: BoxConstraints(
                                  maxWidth: size.width * 0.29,
                                ),
                                child: GestureDetector(
                                  //trip_type
                                  onTap: () {
                                    SelectDialog.showModal<Category>(
                                      context,
                                      showSearchBox: false,
                                      label:
                                          getTranslated(context, 'trip_type'),
                                      items: categoryList,
                                      selectedValue: selectedCategory,
                                      itemBuilder: (BuildContext context,
                                          Category item, bool isSelected) {
                                        return ListTile(
                                          leading: isSelected
                                              ? Icon(
                                                  Icons.circle,
                                                  color: Colors.blue,
                                                )
                                              : Icon(
                                                  Icons.circle,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                      .withOpacity(.3),
                                                ),
                                          title: Text(item.name),
                                          selected: isSelected,
                                        );
                                      },
                                      onChange: (selected) {
                                        setState(() {
                                          selectedCategory = selected;
                                        });
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.05),
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedCategory == null
                                                ? getTranslated(
                                                    context, 'trip_type')
                                                : selectedCategory!
                                                            .name.length >
                                                        8
                                                    ? selectedCategory!.name
                                                        .substring(0, 7)
                                                    : selectedCategory!.name,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            CupertinoIcons.chevron_down,
                                            size: 16,
                                          )
                                        ],
                                      ),
                                    ),
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
                                      initialDate:
                                          selectedDate ?? DateTime.now(),
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
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.05),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedDate == null
                                                ? getTranslated(
                                                    context, 'month')
                                                : '${DateFormat.yMd().format(DateTime.parse(selectedDate.toString()))}',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            CupertinoIcons.chevron_down,
                                            size: 16,
                                          )
                                        ],
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
                              return OfferList(offerList: offerList);
                            else if (loadingFeatured)
                              return Container(
                                height: 400,
                                child: GFLoader(),
                              );
                            else
                              return Container(
                                height: 400,
                                child: Center(
                                  child:
                                      Text(getTranslated(context, 'no_data')),
                                ),
                              );
                          }),
                          Container(
                            height: 100,
                            child: (hasNewData) ? GFLoader() : SizedBox(),
                          )
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
                                        builder: (context) =>
                                            AddNewAdScreen()));
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
              )),
        ));
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imgTemp = File(image.path);
    return showDialog(
        context: context,
        builder: (_) => AddStory(image: imgTemp)).then((value) => value);
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
    ///   print('object');
    setState(() {
      offerPage = 1;
      loadingOffer = true;
      loadingFeatured = true;
      loadingStory = true;
      getResources();
    });
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          height: 50,
          width: size.width * 0.6,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.05),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Center(
            child: TextField(
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
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
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.05),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.filter_list_alt,
                size: 25,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                //  print(search);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchScreen(
                              search: search,
                            )));
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
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.05),
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
