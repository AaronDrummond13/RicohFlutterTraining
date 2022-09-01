import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static late SharedPreferences _sharedPreferences;
  final String ageKey = 'userAge';
  final String nameKey = 'userName';
  static AppPreferences? _instance;

  AppPreferences._internal();

  factory AppPreferences() {
    return _instance ??= AppPreferences._internal();
  }

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setUserAge(int age) {
    return _sharedPreferences.setInt(ageKey, age);
  }

  int getUserAge() {
    int? age = _sharedPreferences.getInt(ageKey);
    age ??= 0;
    return age;
  }

  Future<bool> removeUserAge() async {
    return _sharedPreferences.remove(ageKey);
  }

  Future<bool> setUserName(String name) {
    return _sharedPreferences.setString(nameKey, name);
  }

  String getUserName() {
    String? name = _sharedPreferences.getString(nameKey);
    name ??= '';
    return name;
  }

  Future<bool> removeUserName() async {
    return _sharedPreferences.remove(nameKey);
  }
}
