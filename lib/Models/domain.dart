import 'dart:convert';

Domain domainFromJson(String str) => Domain.fromJson(json.decode(str));

String domainToJson(Domain data) => json.encode(data.toJson());

class Domain {
  Domain({
    required this.id,
    required this.name,
    //required this.name_ar,
    required this.description,
  });

  int id;
  String name;
  //String name_ar;
  String description;

  factory Domain.fromJson(Map<String, dynamic> json) => Domain(
    id: json["id"],
    name: json["name"],
    //name_ar: json["name_ar"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
   // "name_ar": name_ar,
    "description": description,
  };
}
