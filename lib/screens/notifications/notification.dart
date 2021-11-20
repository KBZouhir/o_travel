import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/companies/compay_profile.dart';
import 'package:o_travel/screens/home/components/Ads_widget.dart';
import 'package:o_travel/screens/home/home.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Company> Companys = const <Company>[
    const Company(
        title: 'logopond',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThMuQw_uYqQWSaKwg8KEMHQ2rpLsDNllSiVdl3te6jMAwxY1wKxHa0nZuDpVoClLnH-Lk&usqp=CAU'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
    const Company(
        title: 'Home',
        image:
            'https://logopond.com/logos/eb87954719a4054a051c128a94d1a850.png'),
  ];
  int i = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
        ),
        body: Builder(builder: (context) {
          if (i == 1) {
            return Stack(
              children: [
                Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 60, right: 10, left: 10),
                    width: size.width,
                    height: size.height,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: Companys.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SelectCard(company: Companys[index]);
                        })),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(raduice),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          i = 0;
                        });
                      },
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            'Delete all',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return NoFavoritesWidget(size: size);
          }
        }));
  }
}

class NoFavoritesWidget extends StatelessWidget {
  const NoFavoritesWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 1.1,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Center(
            child: Image.asset(
              'assets/images/noNotifications.png',
            ),
          ),
          SizedBox(
            height: size.height * 0.08,
          ),
          Center(
            child: Text(
              'No Notificationss',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                  color: Theme.of(context).accentColor),
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
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              color: Theme.of(context).primaryColor,
              child: Text(
                'Go back home',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Company {
  const Company({required this.title, required this.image});

  final String title, image;
}

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.company}) : super(key: key);
  final Company company;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CompanyProfile()));
        },
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).accentColor.withOpacity(0.5)),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Center(
                  child: Row(children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: CachedNetworkImage(
                          imageUrl: company.image,
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                          placeholder: (context, url) => Center(
                              child: Container(
                                  width: 10,
                                  height: 10,
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ))),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(company.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).accentColor,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Lorem ipsum dolor sit amet, ...',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).accentColor,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text('3 Hours Ago',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ))
                      ],
                    )
                  ]),
                )),
            Positioned(
              top: 10,
              right: 10,
              width: 30,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.close,
                  size: 18,
                ),
              ),
            )
          ],
        ));
  }
}
