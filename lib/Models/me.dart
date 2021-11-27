import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
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
    required this.tradeRegister,
    required this.wallet,
  });

  int id;
  String name;
  String email;
  String phone;
  String countryCode;
  String image;
  int state;
  int checked;
  dynamic facebook;
  dynamic whatsapp;
  dynamic snapchat;
  dynamic instagram;
  dynamic twitter;
  dynamic rate;
  String latitude;
  String longitude;
  String address;
  dynamic description;
  String tradeRegister;
  String wallet;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    countryCode: json["country_code"],
    image: json["image"],
    state: json["state"],
    checked: json["checked"],
    facebook: json["facebook"],
    whatsapp: json["whatsapp"],
    snapchat: json["snapchat"],
    instagram: json["instagram"],
    twitter: json["twitter"],
    rate: json["rate"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    address: json["address"],
    description: json["description"],
    tradeRegister: json["trade_register"],
    wallet: json["wallet"],
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
    "trade_register": tradeRegister,
    "wallet": wallet,
  };
}
