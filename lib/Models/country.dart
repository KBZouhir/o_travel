import 'dart:convert';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
  Country({
    required this.id,
    required this.name,
    required this.name_ar,
  });

  int id;
  String name;
  String name_ar;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    name: json["name"],
    name_ar: json["name_ar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_ar": name_ar,
  };


  static getCountryNames(List<Country>list,bool isAr){
    String names='';
    for(Country country in list){
      if(isAr)
        names=names+country.name_ar+' , ';
      else
        names=names+country.name;
    }
    return names.length>35?names.substring(0,34)+'...':names;
  }
}