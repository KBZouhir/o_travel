import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/screens/companies/compay_profile.dart';
import 'package:o_travel/screens/localization/const.dart';

class CompaniesGuideScreen extends StatefulWidget {
  const CompaniesGuideScreen({Key? key}) : super(key: key);

  @override
  _CompaniesGuideScreenState createState() => _CompaniesGuideScreenState();
}

class _CompaniesGuideScreenState extends State<CompaniesGuideScreen> {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar:buildAppBar( context),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                child: Container(
                  height: 60,
                  width: size.width,
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
                        fillColor:
                            Theme.of(context).backgroundColor.withOpacity(0),
                        contentPadding: EdgeInsets.zero,
                        hintText: getTranslated(context, 'search'),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.765,
                child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    children: List.generate(Companys.length, (index) {
                      return Center(
                        child: SelectCard(company: Companys[index]),
                      );
                    })),
              )
            ],
          ),
        ));
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
          child: Text(getTranslated(context, 'guide'),
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
              MaterialPageRoute(builder: (context) => CompanyProfile ()));
        },
        child: Container(
            padding: EdgeInsets.all(10),
            height: 300,
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).accentColor),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
                      height: 5,
                    ),
                    Text(company.title,
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        )),
                  ]),
            )));
  }
}
