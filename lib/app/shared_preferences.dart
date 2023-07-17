import 'package:shared_preferences/shared_preferences.dart';

String location = "LOCATIONKEY";
String latitude = "LATITUDEKEY";
String langitude = "LANGITUDEKEY";
String isSkepedOnboarding = 'ISSKEPEDONBOARDINGKEY';
String isLognin = 'ISLOGINKEY';

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);
  // Future<String> getLanguage() async {

  // }

  addlocation(String e) {
    _sharedPreferences.setString(location, e);
  }

  String? getLocation() {
    String? _val = _sharedPreferences.getString(location);
    return _val;
  }

  deleteLocation() {
    _sharedPreferences.remove(location);
  }

  addLatitude(double e) {
    _sharedPreferences.setDouble(latitude, e);
  }

  double? getLatitude() {
    double? _val = _sharedPreferences.getDouble(latitude);
    return _val;
  }

  deleteLatitude() {
    _sharedPreferences.remove(latitude);
  }

  addLangitude(double e) {
    _sharedPreferences.setDouble(langitude, e);
  }

  double? getLangitude() {
    double? _val = _sharedPreferences.getDouble(langitude);
    return _val;
  }

  deleteLangitude() {
    _sharedPreferences.remove(langitude);
  }

  addIsSkepedOnboarding(bool e) {
    _sharedPreferences.setBool(isSkepedOnboarding, e);
  }

  bool? getIsSkepedOnboarding() {
    bool? _val = _sharedPreferences.getBool(isSkepedOnboarding);
    return _val;
  }

  addIsLogin(bool e) {
    _sharedPreferences.setBool(isLognin, e);
  }

  bool? getIsLogin() {
    bool? _val = _sharedPreferences.getBool(isLognin);
    return _val;
  }

  deleteIsLogin() {
    _sharedPreferences.remove(isLognin);
  }
}
