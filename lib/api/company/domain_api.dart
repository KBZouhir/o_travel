import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:o_travel/Models/domain.dart';
import 'package:o_travel/api/CONFIG.dart';

String prifix = "domains";

Future<List<Domain>> getAllDomain() async {
  final response = await http.get(Uri.parse("http://otravel.hexabytes.co/api/company/domains"), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  });
 // print('${response.body}');
  if (response.statusCode == 200) {
    Iterable l = jsonDecode(response.body)['data'];
    return List<Domain>.from(l.map((s) => Domain.fromJson(s)));
  } else {
    throw Exception('Failed to load  $prifix');
  }
}
