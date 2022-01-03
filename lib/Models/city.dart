
import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  City({
    required this.id,
    required this.name,
    required this.name_ar,
    required this.latitude,
    required this.longitude,
  });

  int id;
  String name;
  String name_ar;
  dynamic latitude;
  dynamic longitude;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    name_ar: json["name_ar"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_ar": name_ar,
    "latitude": latitude,
    "longitude": longitude,
  };
}
