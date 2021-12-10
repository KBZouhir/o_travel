
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
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

Future<String> createStory(File image) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';
  // Intilize the multipart request
  final imageUploadRequest =
  http.MultipartRequest('POST', Uri.parse(_url + prifix));

  imageUploadRequest.headers['Authorization'] = 'Bearer $_token';
  // Attach the file in the request
  final mimeTypeData =
  lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])!.split('/');

  final file = await http.MultipartFile.fromBytes(
      'file', await File.fromUri(image.uri).readAsBytes());

  imageUploadRequest.files.add(file);

  try {
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      print('${response.body}');

      return 'null';
    }
    print('${response.body}');
    return '${response.body}';
  } catch (e) {
    print(e);
    return 'null';
  }
}
Future<String> deleteStory(int id) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';

  final response = await http
      .delete(Uri.parse(companyURL + 'stories/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',

      },
      body: jsonEncode(<String, dynamic>{
        "id" : id,
      }));
  if (response.statusCode == 200) {
   return '${response.statusCode}';
  } else {
    throw Exception('Failed to load  $prifix');

  }


}

