import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  void setToken(String token) async {
    SharedPreferences pref = await _pref;
    pref.setString('token', token);
  }

  Future<String> getToken() async {
    SharedPreferences pref = await _pref;
    return pref.getString('token') ?? '';
  }
}
