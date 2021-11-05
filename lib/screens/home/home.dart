import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/settings/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: MyDrawer(size: size),
        appBar: buildAppBar(context),
        body: Container(
          width: size.width,
          height: size.height,
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StorisWidget(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor.withOpacity(0.05),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                SizedBox(
                  height: 10,
                ),
                SearchWidget(size: size),
                SizedBox(
                  height: 20,
                ),
                CarouselWidget(),
                SizedBox(
                  height: 10,
                ),
                FilterWidget(size: size),
                SizedBox(
                  height: 20,
                ),
                AdsContainer(),
                SizedBox(
                  height:30,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: const Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
        ));
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
}
class AdsContainer extends StatelessWidget {
  const AdsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
        children: [
          Container(
          height: MediaQuery.of(context).size.width*0.6,
          width: MediaQuery.of(context).size.width*0.42,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.network('https://media.istockphoto.com/vectors/banner-design-for-discovery-world-tourism-day-travel-agency-and-happy-vector-id1208998439?s=612x612',
                  fit: BoxFit.cover,
                  width: 1000,
                ),
              ),
              Positioned(
                child: Container(
                  height: 60,
                  decoration:
                  BoxDecoration(color: Colors.grey.withOpacity(0.7), borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
                ),bottom: 0,right: 0,left: 0,)
            ],
          ),
        ),
          Spacer(),
          Container(
            height: MediaQuery.of(context).size.width*0.6,
            width: MediaQuery.of(context).size.width*0.42,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.network('https://media.istockphoto.com/vectors/flyer-design-template-for-discovery-world-tourism-day-travel-agency-vector-id1204208073',
                    fit: BoxFit.cover,
                    width: 1000,
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 60,
                    decoration:
                    BoxDecoration(color: Colors.grey.withOpacity(0.7), borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
                  ),bottom: 0,right: 0,left: 0,)
              ],
            ),
          ),],),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.network('https://previews.123rf.com/images/mikalaimanyshau/mikalaimanyshau1412/mikalaimanyshau141200015/34925939-travel-banner-flat-vector-illustration-.jpg',
                  fit: BoxFit.cover,
                  width: 1000,
                ),
              ),
              Positioned(
                child: Container(
                  height: 60,
                  decoration:
                  BoxDecoration(color: Colors.grey.withOpacity(0.7), borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
                ),bottom: 0,right: 0,left: 0,)
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.width*0.6,
              width: MediaQuery.of(context).size.width*0.42,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Image.network('https://media.istockphoto.com/vectors/banner-design-for-discovery-world-tourism-day-travel-agency-and-happy-vector-id1208998439?s=612x612',
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: 60,
                      decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.7), borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
                    ),bottom: 0,right: 0,left: 0,)
                ],
              ),
            ),
            Spacer(),
            Container(
              height: MediaQuery.of(context).size.width*0.6,
              width: MediaQuery.of(context).size.width*0.42,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Image.network('https://media.istockphoto.com/vectors/flyer-design-template-for-discovery-world-tourism-day-travel-agency-vector-id1204208073',
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: 60,
                      decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.7), borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
                    ),bottom: 0,right: 0,left: 0,)
                ],
              ),
            ),],),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.network('https://previews.123rf.com/images/mikalaimanyshau/mikalaimanyshau1412/mikalaimanyshau141200015/34925939-travel-banner-flat-vector-illustration-.jpg',
                  fit: BoxFit.cover,
                  width: 1000,
                ),
              ),
              Positioned(
                child: Container(
                  height: 60,
                  decoration:
                  BoxDecoration(color: Colors.grey.withOpacity(0.7), borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
                ),bottom: 0,right: 0,left: 0,)
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.width*0.6,
              width: MediaQuery.of(context).size.width*0.42,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Image.network('https://media.istockphoto.com/vectors/banner-design-for-discovery-world-tourism-day-travel-agency-and-happy-vector-id1208998439?s=612x612',
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: 60,
                      decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.7), borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
                    ),bottom: 0,right: 0,left: 0,)
                ],
              ),
            ),
            Spacer(),
            Container(
              height: MediaQuery.of(context).size.width*0.6,
              width: MediaQuery.of(context).size.width*0.42,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Image.network('https://media.istockphoto.com/vectors/flyer-design-template-for-discovery-world-tourism-day-travel-agency-vector-id1204208073',
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: 60,
                      decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.7), borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
                    ),bottom: 0,right: 0,left: 0,)
                ],
              ),
            ),],),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.network('https://previews.123rf.com/images/mikalaimanyshau/mikalaimanyshau1412/mikalaimanyshau141200015/34925939-travel-banner-flat-vector-illustration-.jpg',
                  fit: BoxFit.cover,
                  width: 1000,
                ),
              ),
              Positioned(
                child: Container(
                  height: 60,
                  decoration:
                  BoxDecoration(color: Colors.grey.withOpacity(0.7), borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
                ),bottom: 0,right: 0,left: 0,)
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];
    CarouselController buttonCarouselController = CarouselController();

    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }

      return result;
    }

    return Column(children: <Widget>[
      CarouselSlider(
        options: CarouselOptions(
          height: 150,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
        items: imgList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.network(
                        i,
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                    ),
                    Positioned(
                        child: Container(
                      height: 40,
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.7), borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))),
                    ),bottom: 0,right: 0,left: 0,)
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(
          imgList,
          (index, url) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? primaryColorDark
                      : primaryColorLite),
            );
          },
        ),
      ),
    ]);
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({
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
          width: size.width * 0.29,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.05),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Center(
            child: TextField(
              maxLines: 1,
              style: TextStyle(fontSize: 16),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Theme.of(context).iconTheme.color,
                  size: 25,
                ),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                fillColor: Theme.of(context).backgroundColor.withOpacity(0),
                contentPadding: EdgeInsets.zero,
                hintText: 'Trip Type ',
              ),
            ),
          ),
        ),
        SizedBox(
          width:  size.width * 0.03,
        ),
        Container(
          height: 50,
          width: size.width * 0.3,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.05),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Center(
            child: TextField(
              maxLines: 1,
              style: TextStyle(fontSize: 16),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Theme.of(context).iconTheme.color,
                  size: 25,
                ),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                fillColor: Theme.of(context).backgroundColor.withOpacity(0),
                contentPadding: EdgeInsets.zero,
                hintText: 'Country',
              ),
            ),
          ),
        ),
        SizedBox(
          width:  size.width * 0.03,
        ),
        Container(
          height: 50,
          width: size.width * 0.29,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.05),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Center(
            child: TextField(
              maxLines: 1,
              style: TextStyle(fontSize: 16),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Theme.of(context).iconTheme.color,
                  size: 25,
                ),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                fillColor: Theme.of(context).backgroundColor.withOpacity(0),
                contentPadding: EdgeInsets.zero,
                hintText: 'Month',
              ),
            ),
          ),
        ),
      ],
    );
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
              style: TextStyle(fontSize: 20),
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
                hintText: 'Search',
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
              onPressed: () {},
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          height: 50,
          width: size.width * 0.2,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.05),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Center(
            child: Text(
              'Companies\nGuide',
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}

class StorisWidget extends StatelessWidget {
  const StorisWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5),
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.white,
                border:
                    Border.all(color:  Theme.of(context).primaryColor.withOpacity(0.4), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: Icon(Icons.add,
                  size: 30, color:  Theme.of(context).primaryColor.withOpacity(0.4)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color:  Theme.of(context).primaryColor.withOpacity(0.4), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: Icon(Icons.home,
                  size: 30, color:  Theme.of(context).primaryColor.withOpacity(0.4)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color:  Theme.of(context).primaryColor.withOpacity(0.4), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: Icon(Icons.home,
                  size: 30, color:  Theme.of(context).primaryColor.withOpacity(0.4)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color:  Theme.of(context).primaryColor.withOpacity(0.4), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: Icon(Icons.home,
                  size: 30, color:  Theme.of(context).primaryColor.withOpacity(0.4)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color:  Theme.of(context).primaryColor.withOpacity(0.4), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: Icon(Icons.home,
                  size: 30, color:  Theme.of(context).primaryColor.withOpacity(0.4)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color:  Theme.of(context).primaryColor.withOpacity(0.4), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: Icon(Icons.home,
                  size: 30, color:  Theme.of(context).primaryColor.withOpacity(0.4)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color:  Theme.of(context).primaryColor.withOpacity(0.4), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: Icon(Icons.home,
                  size: 30, color:  Theme.of(context).primaryColor.withOpacity(0.4)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 15),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color:  Theme.of(context).primaryColor.withOpacity(0.4), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: Icon(Icons.home,
                  size: 30, color:  Theme.of(context).primaryColor.withOpacity(0.4)),
            ),
          ),
        ],
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              height: size.height * 0.31,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(50)),
                color: primaryColorDark,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 25,
                      ),
                      onPressed: () => Navigator.pop(context)),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt0gx9N5aOyDbSKsuvfJBHC1glECMt7U_VhA&usqp=CAU",
                        height: 95,
                        width: 95,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Spacer(),
                        Text('Home',
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Icon(
                          Icons.edit,
                          color: Colors.grey,
                          size: 25,
                        ),
                        Spacer(),
                      ]))
                ],
              )),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Theme.of(context).accentColor.withOpacity(0.2),
          ),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: const Text(
              'Favorites',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Theme.of(context).accentColor.withOpacity(0.2),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: const Text(
              'Notifications',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Theme.of(context).accentColor.withOpacity(0.2),
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: const Text(
              'Chat',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Theme.of(context).accentColor.withOpacity(0.2),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: const Text(
              'Add New Ad',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Theme.of(context).accentColor.withOpacity(0.2),
          ),
          ListTile(
            leading: Icon(Icons.help_outline_sharp),
            title: const Text(
              'About Us',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Theme.of(context).accentColor.withOpacity(0.2),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: const Text(
              'Contact Us',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 1,
            color: Theme.of(context).accentColor.withOpacity(0.2),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text(
              'Settings',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsScreen()));
            },
          ),
        ],
      ),
    );
  }
}
