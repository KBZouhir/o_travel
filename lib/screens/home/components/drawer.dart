import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/about.dart';
import 'package:o_travel/screens/ads/add.dart';
import 'package:o_travel/screens/chat2/chat_page.dart';
import 'package:o_travel/screens/contact.dart';
import 'package:o_travel/screens/favorites/favories.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:o_travel/screens/notifications/notification.dart';
import 'package:o_travel/screens/privacy.dart';
import 'package:o_travel/screens/profile/company/compay_profile.dart';
import 'package:o_travel/screens/profile/user/user_profile.dart';
import 'package:o_travel/screens/settings/settings.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
    required this.me,
    required this.isCompany,
  }) : super(key: key);

  final dynamic me;
  final bool isCompany;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
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
                (me==null)?GFLoader():
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            if (isCompany)
                              return CompanyProfile(company: me);
                            else
                              return UserProfile(user: me);
                          }));
                    },
                    child: Column(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage
                              (
                              imageUrl: (me != null) ? me.image : '',
                              height: 60,
                              width: 60,
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
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Text((me.name.toString().length>15) ? me.name.toString().substring(0,14)+'...' : me.name.toString(),
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  Spacer(),
                                ]))
                      ],
                    ))
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: Text(
              getTranslated(context, 'home'),
              style: TextStyle(fontSize: 22),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          ),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text(
              getTranslated(context, 'favorites'),
              style: TextStyle(fontSize: 22),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriesScreen()));
            },
          ),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text(
              getTranslated(context, 'notifications'),
              style: TextStyle(fontSize: 22),
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
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text(
              getTranslated(context, 'chat'),
              style: TextStyle(fontSize: 22),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatScreen()));
            },
          ),
          if (isCompany)
            Column(
              children: [
                Divider(
                  height: 1,
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                ),
                ListTile(
                  leading: Icon(Icons.list),
                  title: Text(
                    getTranslated(context, 'add_new_ad_page'),
                    style: TextStyle(fontSize: 22),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNewAdScreen()));
                  },
                ),
              ],
            ),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          ),
          ListTile(
            leading: Icon(Icons.help_outline_sharp),
            title: Text(
              getTranslated(context, 'about'),
              style: TextStyle(fontSize: 22),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutScreen()));
            },
          ),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          ),
          ListTile(
            leading: Icon(Icons.accessible),
            title: Text(
              getTranslated(context, 'privacy_policy'),
              style: TextStyle(fontSize: 22),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PrivacyScreen()));
            },
          ),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(
              getTranslated(context, 'contact_us'),
              style: TextStyle(fontSize: 22),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactScreen()));
            },
          ),
          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              getTranslated(context, 'settings'),
              style: TextStyle(fontSize: 22),
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