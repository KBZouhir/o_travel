import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:o_travel/Models/company.dart';
import 'package:o_travel/api/company/company_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/screens/localization/const.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Company> companies = [];
bool loading=true;
  getResources() {
    getAllCompany().then((value) {
      setState(() {
        companies = value;
        loading =false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getResources();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
        appBar: buildAppBar(context),
        body: Builder(builder: (context) {
          if (companies.length > 0){
            return Stack(
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: 60),
                    width: size.width,
                    height: size.height,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: companies.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SelectCard(company: companies[index],index:index);
                  })
            ],
          )),
          ),
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
                          companies.clear();
                          loading=false;
                        });
                      },
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            getTranslated(context, 'delete_all'),
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
          } else if (loading)
            return Container(
              height: 200,
              child: GFLoader(),
            );
          else{
            return NoFavoritesWidget(size: size);
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
          child: Text(getTranslated(context, 'notifications'),
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
              getTranslated(context, 'no_notifications'),
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
                getTranslated(context, 'go_home'),
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



class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.company, required this.index}) : super(key: key);
  final Company company;
  final int  index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () {
      /*    Navigator.push(context,
              MaterialPageRoute(builder: (context) => CompanyProfile()));*/
        },
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
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
                        Text(company.name,
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
              right: 5,
              left: 5,
              child: Row(
                children: [
                  Expanded(child: Center()),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.close,
                      size: 18,
                    ),
                  ),
                ],
              )
            )
          ],
        ));
  }
}
