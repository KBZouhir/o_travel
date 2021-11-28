
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:o_travel/Models/City.dart';
import 'package:o_travel/Models/company.dart';
import 'package:o_travel/api/CONFIG.dart';
String prifix="me";

Future<Company> getMe() async {
  final response = await http.get(Uri.parse(companyURL + prifix),
      headers:  {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $company_token',
      });
  if (response.statusCode == 200) {
    return  Company.fromJson(jsonDecode(response.body)['data']);
  } else {
    throw Exception('Failed to load  $prifix');

  }

}

