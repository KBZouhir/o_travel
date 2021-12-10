import 'dart:convert';

Company countryFromJson(String str) => Company.fromJson(json.decode(str));

String countryToJson(Company data) => json.encode(data.toJson());


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
    required this.rate,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.description,
    required this.wallet,
  });

  int id;
  String name;
  String email;
  String phone;
  String countryCode;
  String image;
  int state;
  bool checked;
  String facebook;
  String whatsapp;
  String snapchat;
  String instagram;
  String twitter;
  String rate;
  int latitude;
  int longitude;
  String address;
  String description;
  int wallet;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    name: json["name"]??'',
    email: json["email"]??'',
    phone: json["phone"]??'',
    countryCode: json["country_code"]??'',
    image: json["image"]??'',
    state: json["state"]??1,
    checked: json["checked"]??false,
    facebook: json["facebook"]??'',
    whatsapp: json["whatsapp"]??'',
    snapchat: json["snapchat"]??'',
    instagram: json["instagram"]??'',
    twitter: json["twitter"]??'',
    rate: json["rate"]??'',
    latitude: json["latitude"]??0,
    longitude: json["longitude"]??0,
    address: json["address"]??'',
    description: json["description"]??'',
    wallet:json["wallet"]??0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "country_code": countryCode,
    "image": image,
    "state": state,
    "checked": checked,
    "facebook": facebook,
    "whatsapp": whatsapp,
    "snapchat": snapchat,
    "instagram": instagram,
    "twitter": twitter,
    "rate": rate,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "description": description,
    "wallet": wallet,
  };
}
