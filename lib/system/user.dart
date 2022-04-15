import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class User {
  static SharedPreferences? _sharedPrefs;

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  bool get isLogin => _sharedPrefs!.getBool('isLogin') ?? false;

  set isLogin(bool value) {
    _sharedPrefs!.setBool('isLogin', value);
  }

  String get uid => _sharedPrefs!.getString('uid') ?? "";

  set uid(String value) {
    _sharedPrefs!.setString('uid', value);
  }

  String get username => _sharedPrefs!.getString('username') ?? "";

  set username(String value) {
    _sharedPrefs!.setString('username', value);
  }

  String get fullname => _sharedPrefs!.getString('fullname') ?? "";

  set fullname(String value) {
    _sharedPrefs!.setString('fullname', value);
  }

  String get authen_token => _sharedPrefs!.getString('authen_token') ?? "";

  set authen_token(String value) {
    _sharedPrefs!.setString('authen_token', value);
  }

  logout() async {
    await _sharedPrefs!.clear();
  }
}
