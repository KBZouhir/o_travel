import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:o_travel/Models/offer.dart';
import 'package:o_travel/api/CONFIG.dart';
import 'package:shared_preferences/shared_preferences.dart';

String prifix = "offers";

Future<List<Offer>> getAllOffers(String filter_name, String filter_value,int page) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';

  print(_url + prifix + '?$filter_name=$filter_value&page=$page');

  final response = await http
      .get(Uri.parse(_url + prifix + '?$filter_name=$filter_value&page=$page'), headers: {
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

Future<String> createOffer(List<File> imageList, name, description, price, category) async {
  print('${name}');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';
  // Intilize the multipart request
  final imageUploadRequest =
      http.MultipartRequest('POST', Uri.parse(_url + prifix));

  imageUploadRequest.headers['Authorization'] = 'Bearer $_token';

 for(var i=0; i< imageList.length ;i++){
   final file = http.MultipartFile(
       'image[$i]',
       imageList[i].readAsBytes().asStream(),
       imageList[i].lengthSync(),
       filename: imageList[i].path.split("/").last);

   imageUploadRequest.files.add(file);
 }
  imageUploadRequest.fields['name'] = 'name';
  imageUploadRequest.fields['description'] = 'description';
  imageUploadRequest.fields['price'] = '200';
  imageUploadRequest.fields['date'] ='22-10-2021';

  imageUploadRequest.fields['category_id'] = '1';
  imageUploadRequest.fields['countries[0]'] = '1';

  try {
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    print( 'streamedResponse statusCode ${streamedResponse.statusCode} \nheaders ${streamedResponse.headers}\n body ${streamedResponse.request}');
    print( 'Response statusCode ${response.statusCode} \nheaders ${response.headers}\n body ${response.body}');

    if (response.statusCode != 200) {
      print('${response.body}');

      return 'null';
    }
 return'';
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
  if (response.statusCode == 200) {
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

