import 'package:shared_preferences/shared_preferences.dart';

class UserType {
  final bool? isCompany;
  final String? url;

  UserType({required this.isCompany, required this.url});

  Map<String, dynamic> toJson() => {"isCompany": isCompany};

  static Future<bool> getType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isCompany") ?? false;
  }

  static Future<String> getUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("_url") ?? '';
  }

  static void setType(bool type) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isCompany", type);
  }

  static void setUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("_url", url);
  }
}
