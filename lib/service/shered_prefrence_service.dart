import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static final  String _uid = "uid";
  static final bool _isLogin = false;

  static Future<void> setLoginPref(String uid,bool isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_uid, uid);
    await prefs.setBool("isLogin", isLogin);
  }

  static Future<String?> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_uid);
  } 

  static Future<bool> getIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? _isLogin;
  }
}