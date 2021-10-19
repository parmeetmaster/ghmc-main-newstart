import 'package:shared_preferences/shared_preferences.dart';

class SPreference {
  setString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
    return true;
  }

  getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? string = await preferences.getString(key);
    return string;
  }

  clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
