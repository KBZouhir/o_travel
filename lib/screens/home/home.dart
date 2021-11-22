import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/about.dart';
import 'package:o_travel/screens/ads/add.dart';
import 'package:o_travel/screens/ads/show.dart';
import 'package:o_travel/screens/chat/chat_page.dart';
import 'package:o_travel/screens/companies/companies_guide.dart';
import 'package:o_travel/screens/contact.dart';
import 'package:o_travel/screens/favories/favories.dart';
import 'package:o_travel/screens/home/components/Ads_widget.dart';
import 'package:o_travel/screens/home/components/carousel_widget.dart';
import 'package:o_travel/screens/notifications/notification.dart';
import 'package:o_travel/screens/searche/searche.dart';
import 'package:o_travel/screens/settings/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showPassword = true;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  double _KRaduice = 15.0;
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
          child: Stack(
            children: [
              RefreshIndicator(
                color: Theme.of(context).primaryColor,
                key: _refreshIndicatorKey,
                onRefresh: _refresh,
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
                            color:
                                Theme.of(context).accentColor.withOpacity(0.05),
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
                      CarouselWidget(),
                      SizedBox(
                        height: 10,
                      ),
                      FilterWidget(size: size),
                      SizedBox(
                        height: 20,
                      ),
                      AdsContainer(),
                      AdsContainer(),
                      AdsContainer(),
                      AdsContainer(),
                      AdsContainer(),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_KRaduice),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColorDark,
                    ),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen())),
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          'Add New Ad',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.add_box_outlined,
                          color: Colors.white,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
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
    setState(() {});
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
          width: size.width * 0.03,
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
          width: size.width * 0.03,
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchScreen()));

              },
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: (){
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
                'Companies\nGuide',
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
                border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.4),
                    width: 2),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: Icon(Icons.add,
                  size: 30,
                  color: Theme.of(context).primaryColor.withOpacity(0.4)),
            ),
          ),
          StoryItemWidget(),
          StoryItemWidget(),
          StoryItemWidget(),
          StoryItemWidget(),
          StoryItemWidget(),
          StoryItemWidget(),
          StoryItemWidget(),
          StoryItemWidget(),
          StoryItemWidget(),
        ],
      ),
    );
  }
}

class StoryItemWidget extends StatelessWidget {
  const StoryItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowAd()));
    },
    child: Container(
      margin: EdgeInsets.only(right: 15),
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.4), width: 4),
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: CachedNetworkImage(
            imageUrl:
            'https://i.pinimg.com/originals/6d/da/c4/6ddac42ba8f9b79fa5ddd86f4e051e2d.jpg',
            fit: BoxFit.cover,
            width: 1000,
            height: 1000,
            placeholder: (context, url) => Center(
                child: Container(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ))),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        ),
      ),
    ),);
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
              padding:
                  EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
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
                        height: size.height * 0.1,
                        width: size.height * 0.1,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                            width: 50,
                            height: 50,
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ))),
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
                        Text('UserName ',
                            style: TextStyle(
                                fontSize: 25,
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
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoriesScreen()));

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
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsScreen()));
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
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatScreen()));
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
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddNewAdScreen()));
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
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AboutScreen()));
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
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContactScreen()));
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
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
        ],
      ),
    );
  }
}
