
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:o_travel/Models/story.dart';
import 'package:o_travel/api/CONFIG.dart';
import 'package:shared_preferences/shared_preferences.dart';

String prifix="stories";

Future<List<Story>> getAllStory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token =prefs.getString("_token")??'';
  String _url =prefs.getString("_url")??'';
  final response = await http.get(Uri.parse(_url + prifix),
      headers:  {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      });
  if (response.statusCode == 200) {
    Iterable l = jsonDecode(response.body)['data'];
    return List<Story>.from(l.map((s) => Story.fromJson(s)));
  } else {
    print('Failed to load  $prifix');
    return [];
  }

}

