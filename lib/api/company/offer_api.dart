
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/api/CONFIG.dart';

String prifix="offers";

Future<List<Offer>> getAllOffers(String filter_name ,String filter_value) async {
  final response = await http.get(Uri.parse(userURL + prifix +'?$filter_name=$filter_value'),
      headers:  {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $user_token',
      });
  if (response.statusCode == 200) {
    Iterable l = jsonDecode(response.body)['data'];
    return List<Offer>.from(l.map((s) => Offer.fromJson(s)));
  } else {
    throw Exception('Failed to load  $prifix');
  }


}
