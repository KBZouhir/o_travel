
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:o_travel/Models/City.dart';
import 'package:o_travel/api/CONFIG.dart';
String prifix="cities";

Future<List<City>> getAllCity() async {
  final response = await http.get(Uri.parse(companyURL + prifix),
      headers:  {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $company_token',
      });
  if (response.statusCode == 200) {
    Iterable l = jsonDecode(response.body)['data'];
    return List<City>.from(l.map((s) => City.fromJson(s)));
  } else {
    throw Exception('Failed to load  $prifix');
  }

}

