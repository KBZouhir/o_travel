import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:o_travel/Models/company.dart';
import 'package:o_travel/api/company/company_api.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:o_travel/screens/profile/company/show_company_profile.dart';

class CompaniesGuideScreen extends StatefulWidget {
  const CompaniesGuideScreen({Key? key}) : super(key: key);

  @override
  _CompaniesGuideScreenState createState() => _CompaniesGuideScreenState();
}

class _CompaniesGuideScreenState extends State<CompaniesGuideScreen> {
  List<Company> companies = [];
  int companyPage = 1;
  ScrollController _scrollController = new ScrollController();
  bool hasNewData = true;
  getResources() {
    getAllCompany(companyPage).then((value) {
      setState(() {
        companies = value;
        companyPage = 2;
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

        getAllCompany(companyPage).then((value) {
          setState(() {
            if (value.length == 0)
              hasNewData = false;
            else
              companyPage = companyPage + 1;
            companies.addAll(value);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(context),
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.01, horizontal: 16),
                    child: Container(
                      height: 60,
                      width: size.width,
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).accentColor.withOpacity(0.05),
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
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            fillColor: Theme.of(context)
                                .backgroundColor
                                .withOpacity(0),
                            contentPadding: EdgeInsets.zero,
                            hintText: getTranslated(context, 'search'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Builder(builder: (BuildContext context) {
                    if (companies.length > 0)
                      return GridView.count(
                          controller: _scrollController,
                          crossAxisCount: 3,
                          padding: EdgeInsets.all(16),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          children: List.generate(companies.length, (index) {
                            return Center(
                              child: SelectCard(company: companies[index]),
                            );
                          }));
                    else
                      return Container(
                        height: 400,
                        child: GFLoader(),
                      );
                  })
                ],
              ),
            )));
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
        getTranslated(context, 'guide'),
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

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.company}) : super(key: key);
  final Company company;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShowCompanyProfile(company: company)));
        },
        child: Container(
            padding: EdgeInsets.all(10),
            height: 400,
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Hero(
                          tag: 'company_img_${company.id}',
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
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        (company.name.length > 12)
                            ? company.name.substring(0, 12)
                            : company.name,
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        )),
                  ]),
            )));
  }
}
