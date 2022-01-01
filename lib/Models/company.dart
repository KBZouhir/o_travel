// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:o_travel/Models/domain.dart';

import 'city.dart';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

class Company {
  Company({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.countryCode,
    required this.image,
    required this.state,
    required this.checked,
    required this.facebook,
    required this.whatsapp,
    required this.snapchat,
    required this.instagram,
    required this.twitter,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.description,
    required this.trade_register,
    required this.wallet,
    required this.domain,
    required this.city,
    required this.social_media_visible,
  });

  int id;
  String name;
  String email;
  String phone;
  String countryCode;
  String image;
  int? state;
  bool checked;
  bool social_media_visible;
  String facebook;
  String whatsapp;
  String snapchat;
  String instagram;
  String twitter;
  dynamic latitude;
  dynamic longitude;
  String address;
  String description;
  String trade_register;
  int wallet;
  Domain? domain;
  City? city;
  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"] == null ? '' : json["id"],
    name: json["name"] == null ? '' : json["name"],
    email: json["email"] == null ? '' : json["email"],
    phone: json["phone"] == null ? '' : json["phone"],
    countryCode: json["country_code"] == null ? '' : json["country_code"],
    image: json["image"] == null ? '' : json["image"],
    state: json["state"] == null ? 1 : json["state"],
    checked: json["checked"] == null ? false : json["checked"],
    social_media_visible: json["social_media_visible"] == null ? false : json["social_media_visible"],
    facebook: json["facebook"] == null ? '' : json["facebook"],
    whatsapp: json["whatsapp"] == null ? '' : json["whatsapp"],
    snapchat: json["snapchat"] == null ? '' : json["snapchat"],
    instagram: json["instagram"] == null ? '' : json["instagram"],
    twitter: json["twitter"] == null ? '' : json["twitter"],
    latitude: json["latitude"] == null ? 0.0 : json["latitude"],
    longitude: json["longitude"] == null ? 0.0 : json["longitude"],
    address: json["address"] == null ? '' : json["address"],
    description: json["description"] == null ? '' : json["description"],
    trade_register: json["trade_register"] == null ? '' : json["trade_register"],
    wallet: json["wallet"] == null ? 0 : json["wallet"],
    domain: json["domain"] == null ? null : Domain.fromJson(json["domain"]),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "country_code": countryCode == null ? null : countryCode,
    "image": image == null ? null : image,
    "state": state == null ? null : state,
    "checked": checked == null ? false : checked,
    "social_media_visible": social_media_visible == null ? false : social_media_visible,
    "facebook": facebook == null ? null : facebook,
    "whatsapp": whatsapp == null ? null : whatsapp,
    "snapchat": snapchat == null ? null : snapchat,
    "instagram": instagram == null ? null : instagram,
    "twitter": twitter == null ? null : twitter,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "address": address == null ? null : address,
    "description": description == null ? null : description,
    "trade_register": trade_register == null ? null : address,
    "wallet": wallet == null ? null : description,
    "domain": domain == null ? null : domain!.toJson(),
    "city": city == null ? null : city!.toJson(),
  };
}
