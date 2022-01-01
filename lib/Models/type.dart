import 'package:shared_preferences/shared_preferences.dart';

class UserType {
  final bool? isCompany;
  final String? url;
  final int? id;

  UserType({required this.isCompany, required this.url, required this.id});



  static Future<bool> getType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isCompany") ?? false;
  }

  static Future<String> getUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("_url") ?? '';
  }
  static Future<int> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("id") ?? -1;
  }

  static void setType(bool type) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isCompany", type);
  }

  static void setUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("_url", url);
  }
  static void setId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", id);
  }




}
