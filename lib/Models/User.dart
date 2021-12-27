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

  });


  int id;
  String name;
  String email;
  dynamic phone;
  dynamic countryCode;
  String image;
  dynamic state;


  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    countryCode: json["country_code"],
    image: json["image"],
    state: json["state"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "country_code": countryCode,
    "image": image,
    "state": state,

  };



}
