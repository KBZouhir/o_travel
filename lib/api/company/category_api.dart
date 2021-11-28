
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:o_travel/Models/category.dart';
import 'package:o_travel/api/CONFIG.dart';
import 'package:shared_preferences/shared_preferences.dart';

String prifix="categories";

Future<List<Category>> getAllCategory() async {
  final response = await http.get(Uri.parse(companyURL + prifix),
      headers:  {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $company_token',
      });
  if (response.statusCode == 200) {
    Iterable l = jsonDecode(response.body)['data'];
    return List<Category>.from(l.map((s) => Category.fromJson(s)));
  } else {
    throw Exception('Failed to load  $prifix');

  }

}

