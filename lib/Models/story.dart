
import 'dart:convert';

import 'package:o_travel/Models/company.dart';

Story storyFromJson(String str) => Story.fromJson(json.decode(str));

String storyToJson(Story data) => json.encode(data.toJson());

class Story {
  Story({
    required this.id,
    required this.imageUrl,
  });

  int id;
  String imageUrl;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json["id"],
    imageUrl: json["image_url"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
  };
}


