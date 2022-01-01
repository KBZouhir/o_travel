import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:o_travel/Models/city.dart';
import 'package:o_travel/Models/company.dart';
import 'package:o_travel/Models/domain.dart';
import 'package:o_travel/api/company/auth.dart';
import 'package:o_travel/api/company/city_api.dart';
import 'package:o_travel/api/company/domain_api.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/localization/const.dart';
import 'package:select_dialog/select_dialog.dart';

class CompanyProfileEdit extends StatefulWidget {
  const CompanyProfileEdit({Key? key, required this.company}) : super(key: key);
  final Company company;

  @override
  _CompanyProfileEditState createState() => _CompanyProfileEditState();
}

class _CompanyProfileEditState extends State<CompanyProfileEdit> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController gpsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController fieldController = TextEditingController();
  TextEditingController commercialController = TextEditingController();
  TextEditingController snapController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController fbController = TextEditingController();
  TextEditingController tweeterController = TextEditingController();
 File? image;
 File? register;
  late String registerName;
  late String phone;
  late String countryCode;
  List<City> cityList = [];
 late City selectedCity;

  List<Domain> domainList = [];
  late Domain selectedDomain;

  getResources() {
    getAllDomain().then((value) {
      setState(() {
        domainList = value;
       // if(value.length>0)selectedDomain=widget.company.domain;
      });
    });

    getAllCity().then((value) {
      setState(() {
        cityList = value;
       // if(value.length>0)selectedCity=widget.company.city;

      });
    });
  }
  @override
  void initState() {
    super.initState();
    usernameController.text = widget.company.name;
    emailController.text = widget.company.email;
    phoneController.text = widget.company.phone;
    aboutController.text = widget.company.description;
    addressController.text=widget.company.address;
    gpsController.text =
        '${widget.company.latitude} ${widget.company.latitude}';

    instaController.text = widget.company.instagram;
    fbController.text = widget.company.facebook;
    tweeterController.text = widget.company.twitter;
    phone = widget.company.phone;
   countryCode = widget.company.countryCode;
   registerName = (widget.company.trade_register.length>50)?widget.company.trade_register.substring(0,49):widget.company.trade_register;


    getResources();
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose() ;
    emailController.dispose();
    phoneController.dispose();
    aboutController.dispose();
    addressController.dispose();
    gpsController.dispose();

    instaController.dispose();
    fbController.dispose();
    tweeterController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      selectedCity=widget.company.city!;
      cityList.add(selectedCity);
      selectedDomain=widget.company.domain!;
      domainList.add(selectedDomain);
    });
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
                padding:
                    EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
                height: 220,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(raduice)),
                  color: primaryColorDark,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 25,
                            ),
                            onPressed: () => Navigator.pop(context)),
                        Spacer(),
                        Text(
                          getTranslated(context, 'edit_profile'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        SizedBox(width: 55)
                      ],
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          pickImage(true);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child:(image==null)? CachedNetworkImage(
                            imageUrl: widget.company.image,
                            height: 100,
                            width: 100,
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
                          ):Image.file(image!,height: 100,
                            width: 100,),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      getTranslated(context, 'company_name'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: usernameController,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: getTranslated(context, 'company_name'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(raduice))),
                        prefixIcon: Icon(
                          Icons.perm_identity,
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      getTranslated(context, 'about_company'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: aboutController,
                      onChanged: (val) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.multiline,
                      maxLength: 300,
                      minLines:5,
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(raduice))),
                      ),
                      style: TextStyle(
                        height: 1.6,
                        fontSize: 20,
                        decorationThickness: 0,
                      ), // when user presses enter it will adapt to it
                    ),
                    SizedBox(height: 16),
                    Text(
                      getTranslated(context, 'email'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: getTranslated(context, 'email'),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(raduice))),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      getTranslated(context, 'phone'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.secondary),
                          borderRadius: BorderRadius.all(Radius.circular(raduice))),
                      child: IntlPhoneField(
                        controller: phoneController,
                        initialCountryCode: countryCode,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: getTranslated(context, 'phone'),
                            border: InputBorder.none,
                            counterText: "",
                            contentPadding: EdgeInsets.only(bottom: 15)),
                        onChanged: (phone) {
                          setState(() {
                            this.phone = phone.number!;
                          });
                        },
                        onCountryChanged: (dynamic phone) {
                          setState(() {
                            this.countryCode = phone.countryCode;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      getTranslated(context, 'address'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: addressController,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: getTranslated(context, 'address'),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(raduice))),
                        prefixIcon: Icon(Icons.map),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      getTranslated(context, 'location_gps'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: gpsController,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: getTranslated(context, 'location_gps'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(raduice))),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      getTranslated(context, 'area'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        SelectDialog.showModal<City>(
                          context,
                          showSearchBox: false,
                          label: getTranslated(context, 'area'),
                          selectedValue: selectedCity,
                          items: List.generate(
                              cityList.length, (index) => cityList[index]),
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
                              title: Text(item.name,style: TextStyle(fontSize: 20),),
                              selected: isSelected,
                            );
                          },
                          onChange: (City selected) {
                            setState(() {
                              selectedCity = selected;
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Theme.of(context).backgroundColor,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.secondary)),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedCity==null
                                    ? getTranslated(context, 'country')
                                    : selectedCity.name,
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(CupertinoIcons.chevron_down,size: 16,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      getTranslated(context, 'field'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        SelectDialog.showModal<Domain>(
                          context,
                          showSearchBox: false,
                          label: getTranslated(context, 'field'),
                          selectedValue: selectedDomain,
                          items: List.generate(
                              domainList.length, (index) => domainList[index]),
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
                              title: Text(item.name,style: TextStyle(fontSize: 20),),
                              selected: isSelected,
                            );
                          },
                          onChange: (Domain selected) {
                            setState(() {
                              selectedDomain = selected;
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Theme.of(context).backgroundColor,
                            border: Border.all(
                                color: Theme.of(context).colorScheme.secondary)),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDomain==null
                                    ? getTranslated(context, 'country')
                                    : selectedDomain.name,
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(CupertinoIcons.chevron_down,size: 16,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      getTranslated(context, 'commercial_register'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(raduice)),
                        border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.7))
                      ),
                      child: Row(
                      children: [
                        IconButton(onPressed: (){
                          pickImage(false);

                        }, icon: Icon(Icons.add_photo_alternate,color: Theme.of(context).colorScheme.secondary),),
                      Text((registerName.length!=0)?registerName:getTranslated(context, 'commercial_register'),style: TextStyle(fontSize:20,color: Theme.of(context).colorScheme.secondary),)
                      ],
                    ),),
                    SizedBox(height: 16),
                    Text(
                      getTranslated(context, 'snapchat'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: snapController,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                      obscureText: false,
                      decoration: InputDecoration(
                       // prefixIcon: SvgPicture.asset('assets/icons/snap.svg'),
                        hintText: getTranslated(context, 'snapchat'),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(raduice))),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      getTranslated(context, 'instagram'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: instaController,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: getTranslated(context, 'instagram'),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(raduice))),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      getTranslated(context, 'facebook'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: fbController,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: getTranslated(context, 'facebook'),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(raduice))),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      getTranslated(context, 'tweeter'),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: tweeterController,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.secondary),
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: getTranslated(context, 'tweeter'),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(raduice))),
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                          updateCompany(
                            register,
                            usernameController.text,
                            aboutController.text,
                            emailController.text,
                            phoneController.text,
                            countryCode,
                            addressController.text,
                            snapController.text,
                            fbController.text,
                            tweeterController.text,
                            instaController.text,
                            selectedCity.id,
                            selectedDomain.id,
                          );
                        },
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          getTranslated(context, 'save'),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
  Future pickImage(bool isProfile) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imgTemp = File(image.path);
    setState(() {
      if(isProfile){
        this.image = imgTemp;
        updateImg(imgTemp);
      }else{
        this.register = imgTemp;
        this.registerName = image.name;
      }

    });

  }
}
