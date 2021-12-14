import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:o_travel/Models/company.dart';
import 'package:o_travel/api/CONFIG.dart';
import 'package:shared_preferences/shared_preferences.dart';

String prifix = "companies";

Future<List<Company>> getAllCompany(int page) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';

  final response =
      await http.get(Uri.parse(userURL + prifix + '&page=$page'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $user_token',
  });

  if (response.statusCode == 200) {
    Iterable l = jsonDecode(response.body)['data'];
    return List<Company>.from(l.map((s) => Company.fromJson(s)));
  } else {
    print('Failed to load  $prifix');
    return [];
  }
}
