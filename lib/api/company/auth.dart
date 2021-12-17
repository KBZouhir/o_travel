import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:o_travel/Models/company.dart';
import 'package:o_travel/Models/User.dart';
import 'package:o_travel/Models/token.dart';
import 'package:o_travel/Models/type.dart';
import 'package:o_travel/api/CONFIG.dart';
import 'package:o_travel/screens/auth/choose_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const prifix = '';

Future<bool> loginCompany(email, password,uid,deviceToken) async {
  final response = await http.post(Uri.parse(companyURL + 'login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "email": email,
        "password": password,
        "device_token": deviceToken,
        "uid": uid
      }));
  print('${response.body}');
  if (response.statusCode == 200) {
    UserType.setType(true);
    Token.setToken(jsonDecode(response.body)['access_token']);
    UserType.setUrl(companyURL);
    return true;
  } else {
    return false;

  }
}

Future<Company> registerCompany(name, email, password, confirm_password,
    country_code, phone, city_id, domain_id, device_token) async {
  final response = await http.post(Uri.parse(companyURL + 'register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": confirm_password,
        "country_code": country_code,
        "phone": phone,
        'city_id': city_id,
        'domain_id': domain_id,
        "device_token":device_token,
      }));
  print('${response.body}');
  if (response.statusCode == 200) {
    UserType.setType(true);
    Token.setToken(jsonDecode(response.body)['access_token']);
    UserType.setUrl(companyURL);
    return Company.fromJson(jsonDecode(response.body)['company']);
  } else {
    throw Exception(response.body);
  }
}

Future<User> loginUser(email, password) async {
  final response = await http.post(Uri.parse(userURL + 'login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "email": email,
        "password": password,
        "device_token": "fcm token from firebase",
        "uid": "user id in firebase"
      }));
  if (response.statusCode == 200) {
    UserType.setType(false);
    Token.setToken(jsonDecode(response.body)['access_token']);
    UserType.setUrl(userURL);
    return User.fromJson(jsonDecode(response.body)['user']);
  } else {
    throw Exception('Failed to load  $prifix');
  }
}

Future<User> registerUser(name, email, password, confirm_password, country_code,
    phone, device_token) async {
  final response = await http.post(Uri.parse(userURL + 'register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": confirm_password,
        "country_code": country_code,
        "phone": phone,
        "device_token": "fcm token from firebase",
      }));
  if (response.statusCode == 200) {
    UserType.setType(false);
    Token.setToken(jsonDecode(response.body)['access_token']);
    UserType.setUrl(userURL);
    return User.fromJson(jsonDecode(response.body)['user']);
  } else {
    throw Exception(response.body);
  }
}

Future<String> updateImg(File image) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';
  // Intilize the multipart request
  final uploadRequest =
      http.MultipartRequest('POST', Uri.parse(_url + 'upload/image'));

  uploadRequest.headers['Authorization'] = 'Bearer $_token';
  uploadRequest.headers['Accept'] = 'application/json';
  uploadRequest.headers['X-Requested-With'] = 'XMLHttpRequest';

  final file = http.MultipartFile(
      'image', image.readAsBytes().asStream(), image.lengthSync(),
      filename: image.path.split("/").last);

  uploadRequest.files.add(file);

  try {
    final streamedResponse = await uploadRequest.send();
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

Future<Company> getCompany() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';
  final response = await http.get(Uri.parse(_url + 'me'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $_token',
  });
  if (response.statusCode == 200) {
    return Company.fromJson(jsonDecode(response.body)['data']);
  } else {
    throw Exception('Failed to load  $prifix');
  }
}

Future<User> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';
  final response = await http.get(Uri.parse(_url + 'me'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $_token',
  });
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body)['user']);
  } else {
    throw Exception('Failed to load  user');
  }
}

void logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';
  prefs.clear();

  Navigator.of(context).pop();
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => ChoosePage()));
  final response = await http.post(Uri.parse(_url + 'logout'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $_token',
  });

  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to load  $prifix');
  }
}

Future<String> updateCompany(File?
  tradeRegister,
  name,
  description,
  email,
  phone,
  countryCode,
  address,
  snapchat,
  facebook,
  tweeter,
  instagram,
    cityId,
  domainId,
) async {
  print(
      '$name, $description, $email, $phone, $countryCode, $address, $snapchat, $facebook, $tweeter, $instagram, $cityId, $domainId');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';
  // Intilize the multipart request
  final uploadRequest =
  http.MultipartRequest('POST', Uri.parse(_url + 'update'));

  uploadRequest.headers['Authorization'] = 'Bearer $_token';
  uploadRequest.headers['Accept'] = 'application/json';
  uploadRequest.headers['X-Requested-With'] = 'XMLHttpRequest';
  if (tradeRegister != null){
    final file = http.MultipartFile('trade_register',
        tradeRegister.readAsBytes().asStream(), tradeRegister.lengthSync(),
        filename: tradeRegister.path
            .split("/")
            .last);

  uploadRequest.files.add(file);
}

  uploadRequest.fields['name'] = '$name';
  uploadRequest.fields['description'] = '$description';
  uploadRequest.fields['email'] = '$email';
  uploadRequest.fields['phone'] = '$phone';
  uploadRequest.fields['country_code'] = '$countryCode';
  uploadRequest.fields['address'] = '$address';
  uploadRequest.fields['snapchat'] = '$snapchat';
  uploadRequest.fields['facebook'] = '$facebook';
  uploadRequest.fields['tweeter'] = '$tweeter';
  uploadRequest.fields['instagram'] = '$instagram';

  uploadRequest.fields['city_id'] = '$cityId';
  uploadRequest.fields['domain_id'] = '$domainId';
  uploadRequest.fields['_method'] = 'put';
  /*  uploadRequest.fields['price'] = price;
  uploadRequest.fields['date'] = '$month';

  uploadRequest.fields['category_id'] = '$categoryId';
  uploadRequest.fields['countries[0]'] = '$countryId';*/

  try {
    final streamedResponse = await uploadRequest.send();
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

Future<bool> updateUser(username ,email,phone) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token = prefs.getString("_token") ?? '';
  String _url = prefs.getString("_url") ?? '';
  final response = await http.post(Uri.parse(_url + 'logout'), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $_token',
  });

  if (response.statusCode == 200) {
    return  true;
  } else {
    return false;
    throw Exception('Failed to load  $prifix');
  }
}
