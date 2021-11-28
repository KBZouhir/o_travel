
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:o_travel/Models/category.dart';
import 'package:o_travel/Models/country.dart';
import 'package:o_travel/api/CONFIG.dart';
import 'package:shared_preferences/shared_preferences.dart';

String prifix="countries";

Future<List<Country>> getAllCountry() async {
  final response = await http.get(Uri.parse(companyURL + prifix),
      headers:  {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $company_token',
      });
  if (response.statusCode == 200) {
    Iterable l = jsonDecode(response.body)['data'];
    return List<Country>.from(l.map((s) => Country.fromJson(s)));
  } else {
    throw Exception('Failed to load  $prifix');
  }

}

