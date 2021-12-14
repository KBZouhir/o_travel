import 'dart:async';
import 'dart:convert';
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

Future<Company> loginCompany(email,password) async {
    final response = await http
        .post(Uri.parse(companyURL + 'login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "email" : email,
          "password": password,
          "device_token" : "dfg",
          "uid" : "user id in firebase"
        }));
    print('${response.body}');
  if (response.statusCode == 200) {
      UserType.setType(true);
      Token.setToken(jsonDecode(response.body)['access_token']);
      UserType.setUrl(companyURL);
      return  Company.fromJson(jsonDecode(response.body)['seller']);
    } else {
      throw Exception('Failed to load  $prifix');

    }
}
Future<Company> registerCompany(name,email,password,confirm_password,country_code,phone,city_id,domain_id,device_token) async {

  final response = await http
      .post(Uri.parse(userURL + 'register' ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "name" : name,
        "email" : email,
        "password": password,
        "password_confirmation": confirm_password,
        "country_code": country_code,
        "phone": phone,
        'city_id':city_id,
        'domain_id':domain_id,
        "device_token" : "fcm token from firebase",
      }));
  if (response.statusCode==200) {
    UserType.setType(true);
    Token.setToken(jsonDecode(response.body)['access_token']);
    UserType.setUrl(companyURL);
    return  Company.fromJson(jsonDecode(response.body)['company']);
  }else{
    throw Exception(response.body);
  }
}






Future<User> loginUser(email,password) async {
    final response = await http
        .post(Uri.parse(userURL + 'login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "email" : email,
          "password": password,
          "device_token" : "fcm token from firebase",
          "uid" : "user id in firebase"
        }));
    if (response.statusCode==200) {
      UserType.setType(false);
      Token.setToken(jsonDecode(response.body)['access_token']);
      UserType.setUrl(userURL);
      return  User.fromJson(jsonDecode(response.body)['user']);
    }else{
      throw Exception('Failed to load  $prifix');
    }
}
Future<User> registerUser(name,email,password,confirm_password,country_code,phone,device_token) async {

  final response = await http
      .post(Uri.parse(userURL + 'register' ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "name" : name,
        "email" : email,
        "password": password,
        "password_confirmation": confirm_password,
        "country_code": country_code,
        "phone": phone,
        "device_token" : "fcm token from firebase",
      }));
  if (response.statusCode==200) {
    UserType.setType(false);
    Token.setToken(jsonDecode(response.body)['access_token']);
    UserType.setUrl(userURL);
    return  User.fromJson(jsonDecode(response.body)['user']);
  }else{
throw Exception(response.body);
  }
}
Future<int> update(company) async {
  final response = await http
      .post(Uri.parse(baseURL + 'register' ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        '_method':'put',
      'name':'O-travel',
      'email':'company1@app.com',
      'phone':'1234567890',
      'country_code':'+213',
      'city_id':'1',
      'domain_id':'1',
      'facebook':'https://www.facebook.com/',
      'twitter':'https://twitter.com/',
      'instagram':'https://www.instagram.com/',
      'snapchat':'https://www.snapchat.com/',
      'longitude':'6.569092',
      'latitude':'36.228447',
      'address':'this is dummy address',

      }));
  if (response.statusCode==200) {

  }else{

  }
  return 0;
}
Future<int> updateImage(company) async {
  final response = await http
      .post(Uri.parse(baseURL + 'register' ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'image':'image',
      }));
  if (response.statusCode==200) {

  }else{

  }
  return 0;
}
Future<Company> getCompany() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token =prefs.getString("_token")??'';
  String _url =prefs.getString("_url")??'';
  final response = await http.get(Uri.parse(_url + 'me'),
      headers:  {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      });
  if (response.statusCode == 200) {
    return  Company.fromJson(jsonDecode(response.body)['data']);
  } else {
    throw Exception('Failed to load  $prifix');

  }

}
Future<User> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token =prefs.getString("_token")??'';
  String _url =prefs.getString("_url")??'';
  final response = await http.get(Uri.parse(_url + 'me'),
      headers:  {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_token',
      });
  if (response.statusCode == 200) {
    return  User.fromJson(jsonDecode(response.body)['user']);
  } else {
    throw Exception('Failed to load  $prifix');

  }

}

void logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _token =prefs.getString("_token")??'';
  String _url =prefs.getString("_url")??'';
  prefs.clear();

  Navigator.of(context).pop();
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChoosePage()));
  final response = await http
      .post(Uri.parse(_url + 'logout'),
      headers:  {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
      });

  if (response.statusCode == 200) {


  } else {
    throw Exception('Failed to load  $prifix');

  }
}
