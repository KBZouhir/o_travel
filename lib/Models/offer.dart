// To parse this JSON data, do
//
//     final offer = offerFromJson(jsonString);

import 'dart:convert';

import 'package:o_travel/Models/category.dart';
import 'package:o_travel/Models/company.dart';
import 'package:o_travel/Models/country.dart';
import 'package:o_travel/Models/image.dart';

Offer offerFromJson(String str) => Offer.fromJson(json.decode(str));

String offerToJson(Offer data) => json.encode(data.toJson());

class Offer {
  Offer({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.rate,
    required this.date,
    required this.favoriteByMe,
    required this.state,
    required this.featured,
    required this.images,
    required this.category,
    required this.company,
    required this.countries,
  });

  int id;
  String name;
  int price;
  String description;
  dynamic rate;
  DateTime date;
  bool favoriteByMe;
  int state;
  int featured;
  List<Image> images;
  Category category;
  Company company;
  List<Country> countries;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        rate: json["rate"],
        date: DateTime.parse(json["date"]),
        favoriteByMe: json["favorite_by_me"],
        state: json["state"],
        featured: json["featured"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        category: Category.fromJson(json["category"]),
        company: Company.fromJson(json["company"]),
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "rate": rate,
        "date": date.toIso8601String(),
        "favorite_by_me": favoriteByMe,
        "state": state,
        "featured": featured,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "category": category.toJson(),
        "company": company.toJson(),
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'Offer{id: $id, name: $name, price: $price, description: $description, rate: $rate, date: $date, favoriteByMe: $favoriteByMe, state: $state, featured: $featured, images: $images, category: $category, company: $company, countries: $countries}';
  }
}
