import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:o_travel/Models/country.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/api/CONFIG.dart';
import 'package:shared_preferences/shared_preferences.dart';

String prifix = "offers";
Future<List<Offer>> fetchOffers(String filter, int page) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';

  print(_url + prifix + '?page=$page$filter');

  final response = await http.get(
      Uri.parse(_url + prifix + '?page=$page$filter'),
      headers: {
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
Future<List<Offer>> getAllOffers(
    String filter_name, String filter_value, int page) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';

  print(_url + prifix + '?$filter_name=$filter_value&page=$page');

  final response = await http.get(
      Uri.parse(_url + prifix + '?$filter_name=$filter_value&page=$page'),
      headers: {
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

Future<List<Offer>> getCompanyOffers( int page) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';

  print(_url + prifix + '?page=$page');

  final response = await http.get(
      Uri.parse(_url + prifix + '?page=$page'),
      headers: {
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

Future<String> createOffer(List<File> imageList, name, description, price,
    categoryId, countryId, month) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';
  // Intilize the multipart request
  final imageUploadRequest =
      http.MultipartRequest('POST', Uri.parse(_url + prifix));

  imageUploadRequest.headers['Authorization'] = 'Bearer $_token';
  imageUploadRequest.headers['Accept'] = 'application/json';
  imageUploadRequest.headers['X-Requested-With'] = 'XMLHttpRequest';

  for (var i = 0; i < imageList.length; i++) {
    final file = http.MultipartFile('images[$i]',
        imageList[i].readAsBytes().asStream(), imageList[i].lengthSync(),
        filename: imageList[i].path.split("/").last);

    imageUploadRequest.files.add(file);
  }
  imageUploadRequest.fields['name'] = '$name';
  imageUploadRequest.fields['description'] = '$description';
  imageUploadRequest.fields['price'] = price;
  imageUploadRequest.fields['date'] = '$month';

  imageUploadRequest.fields['category_id'] = '$categoryId';
  imageUploadRequest.fields['countries[0]'] = '$countryId';

  try {
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    print(
        'streamedResponse statusCode ${streamedResponse.statusCode} \nheaders ${streamedResponse.headers}\n body ${streamedResponse.request}');
    print(
        'Response statusCode ${response.statusCode} \nheaders ${response.headers}\n body ${response.body}');

    if (response.statusCode != 200) {
      print('${response.body}');

      return 'null';
    }
    return '';
  } catch (e) {
    print(e);
    return 'null';
  }
}

Future addToFavorites(int offerId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';
  final response = await http.post(Uri.parse(_url + 'offers/$offerId/favorite'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode(<String, dynamic>{
        "id": offerId,
      }));
  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to load  $prifix');
  }
}

Future<bool> deleteOffer(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';

  final response = await http.delete(Uri.parse(companyURL + prifix + '/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode(<String, dynamic>{
        "id": id,
      }));
  print('${response.body}');
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
    throw Exception('Failed to load  $prifix');
  }
}
