import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:o_travel/Models/category.dart';
import 'package:o_travel/api/CONFIG.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<String>privacy() async {

  final response = await http.get(Uri.parse(userURL + 'privacy_policy'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  });
  print('${response.body}');
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['privacy_policy'];

  } else {
    return '';
  }
}
Future<String>about() async {

  final response = await http.get(Uri.parse(userURL + 'about_us'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  });
  print('${response.body}');

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['about_us'];
  } else {
    return '';
  }
}Future<String>termOfUse() async {
  final response = await http.get(Uri.parse(userURL + 'terms_of_use'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  });
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['about_us'];
  } else {
    return '';
  }
}