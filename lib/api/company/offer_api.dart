import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/api/CONFIG.dart';
import 'package:shared_preferences/shared_preferences.dart';

String prifix = "offers";

Future<List<Offer>> getAllOffers(
    String filter_name, String filter_value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';

  final response = await http
      .get(Uri.parse(_url + prifix + '?$filter_name=$filter_value'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $_token',
  });
  if (response.statusCode == 200) {
    Iterable l = jsonDecode(response.body)['data'];
    return List<Offer>.from(l.map((s) => Offer.fromJson(s)));
  } else {
    print('Failed to load  $prifix');
    return [];
  }
}

Future<String> createOffer(File image1, File image2, File image3, name,
    description, price, category) async {
  print('${name}');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';
  // Intilize the multipart request
  final imageUploadRequest =
      http.MultipartRequest('POST', Uri.parse(_url + prifix));

  imageUploadRequest.headers['Authorization'] = 'Bearer $_token';
  // Attach the file in the request
  final mimeTypeData =
      lookupMimeType(image1.path, headerBytes: [0xFF, 0xD8])!.split('/');

  final file1 = await http.MultipartFile.fromBytes(
      'file', await File.fromUri(image1.uri).readAsBytes());

  imageUploadRequest.files.add(file1);
  imageUploadRequest.fields['name'] = name;
  imageUploadRequest.fields['description'] = description;
  imageUploadRequest.fields['price'] = price;
  imageUploadRequest.fields['date'] =
      DateFormat.yMd().format(DateTime.parse(DateTime.now().toString()));
  imageUploadRequest.fields['category_id'] = category;
  imageUploadRequest.fields['countries[0]'] = '1';

  try {
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      print('${response.body}');

      return 'null';
    }
    final Map<String, dynamic> responseData = json.decode(response.body);
    print('$responseData');
    return responseData['message'];
  } catch (e) {
    print(e);
    return 'null';
  }
}

Future addToFavorites(int offerId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';
  final response = await http
      .post(Uri.parse(_url + 'offers/$offerId/favorite'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode(<String, dynamic>{
        "id" : offerId,
      }));
  print('${response.body}');

  if (response.statusCode == 200) {
  print('${response.body}');
  } else {
    throw Exception('Failed to load  $prifix');

  }
}

Future<String> deleteOffer(int id) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';

  final response = await http
      .delete(Uri.parse(companyURL +prifix +'/$id'),
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

