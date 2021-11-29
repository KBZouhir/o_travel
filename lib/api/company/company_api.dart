import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:o_travel/Models/company.dart';
import 'package:o_travel/api/CONFIG.dart';

String prifix="companies";

Future<List<Company>> getAllCompany() async {
  final response = await http.get(Uri.parse(userURL + prifix),
      headers:  {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $user_token',
      });

  if (response.statusCode == 200) {
    Iterable l = jsonDecode(response.body)['data'];
    return List<Company>.from(l.map((s) => Company.fromJson(s)));
  } else {
    throw Exception('Failed to load  $prifix \n ${response.body}');

  }

}

