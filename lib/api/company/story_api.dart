
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:o_travel/Models/story.dart';
import 'package:o_travel/api/CONFIG.dart';

String prifix="stories";

Future<List<Story>> getAllStory() async {
  final response = await http.get(Uri.parse(companyURL + prifix),
      headers:  {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $company_token',
      });
  if (response.statusCode == 200) {
    Iterable l = jsonDecode(response.body)['data'];
    return List<Story>.from(l.map((s) => Story.fromJson(s)));
  } else {
    throw Exception('Failed to load  $prifix');

  }

}

