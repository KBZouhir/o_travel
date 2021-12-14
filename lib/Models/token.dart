import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Token extends ChangeNotifier {
  final String token;
  final String token_type;

  Token({required this.token, required this.token_type});

  Token.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        token_type = json['token_type'];

  Map<String, dynamic> toJson() => {
        '_token': token,
        'token_type': token_type,
      };

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("_token") ?? '';
  }

  static void setToken(String _token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("_token", _token);
  }
}
