
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:o_travel/Models/city.dart';
import 'package:o_travel/Models/type.dart';
import 'package:o_travel/api/CONFIG.dart';
import 'package:shared_preferences/shared_preferences.dart';
String prifix="cities";

Future<List<City>> getAllCity() async {
  final response = await http.get(Uri.parse(userURL + prifix),
      headers:  {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $user_token',
      });
  if (response.statusCode == 200) {
    Iterable l = jsonDecode(response.body)['data'];
    return List<City>.from(l.map((s) => City.fromJson(s)));
  } else {
    print('Failed to load  $prifix');
    return [];
  }

}

