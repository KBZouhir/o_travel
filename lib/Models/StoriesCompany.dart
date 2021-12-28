// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:o_travel/Models/domain.dart';
import 'package:o_travel/Models/story.dart';

import 'city.dart';

StoryCompany companyFromJson(String str) => StoryCompany.fromJson(json.decode(str));

String companyToJson(StoryCompany data) => json.encode(data.toJson());

class StoryCompany {
  StoryCompany({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.countryCode,
    required this.image,
    required this.state,
    required this.checked,
    required this.stories,
  });

  int id;
  String name;
  String email;
  String phone;
  String countryCode;
  String image;
  int? state;
  bool? checked;
  List<Story> stories;

  factory StoryCompany.fromJson(Map<String, dynamic> json) => StoryCompany(
    id: json["id"] == null ? '' : json["id"],
    name: json["name"] == null ? '' : json["name"],
    email: json["email"] == null ? '' : json["email"],
    phone: json["phone"] == null ? '' : json["phone"],
    countryCode: json["country_code"] == null ? '' : json["country_code"],
    image: json["image"] == null ? '' : json["image"],
    state: json["state"] == null ? 1 : json["state"],
    checked: json["checked"] == null ? false : json["checked"],
    stories: List<Story>.from(
        json["stories"].map((x) => Story.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "country_code": countryCode == null ? null : countryCode,
    "image": image == null ? null : image,
    "state": state == null ? null : state,
    "checked": checked == null ? null : checked,
    "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
  };
}
