import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:o_travel/Models/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

String prifix = "categories";

Future<List<Category>> getAllCategory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';
  final response = await http.get(Uri.parse(_url + prifix), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $_token',
  });
  if (response.statusCode == 200) {
    Iterable l = jsonDecode(response.body)['data'];
    return List<Category>.from(l.map((s) => Category.fromJson(s)));
  } else {
    print('Failed to load  $prifix');
    return [];
  }
}
