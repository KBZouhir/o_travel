
import 'dart:convert';

import 'package:o_travel/Models/company.dart';

Story storyFromJson(String str) => Story.fromJson(json.decode(str));

String storyToJson(Story data) => json.encode(data.toJson());

class Story {
  Story({
    required this.id,
    required this.imageUrl,
    required this.company,
  });

  int id;
  String imageUrl;
  Company company;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json["id"],
    imageUrl: json["image_url"],
    company: Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "company": company.toJson(),
  };
}


