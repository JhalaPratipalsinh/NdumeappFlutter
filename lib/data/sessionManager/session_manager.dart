import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../util/constants.dart';
import '../models/login_model.dart';

class SessionManager {
  final SharedPreferences _preferences;
  LoginModel? _loginDetail;

  SessionManager(this._preferences);

  Future<void> initiateUserLogin(LoginModel loginDetails) async {
    _loginDetail = null;
    final userDetails = json.encode(loginDetails.toJson());
    _preferences.setString(userData, userDetails);
    _preferences.setBool(isLoggedIn, true);
  }

  LoginModel? getUserDetails() {
    if (_loginDetail == null) {
      final value = _preferences.getString(userData) ?? '';
      final userDetails = json.decode(value) as Map<String, dynamic>;
      _loginDetail = LoginModel.fromJson(userDetails);
    }
    return _loginDetail;
  }

  String getToken() {
    late final String token;
    if (getUserDetails() == null) {
      token = '';
    } else {
      token = getUserDetails()!.data!.accessToken!;
    }
    return token;
  }


  /*void setMpesaToken(String token) {
    _preferences.setString(mpesaToken, token);
  }

  String getMpesaToken() {
    return _preferences.getString(mpesaToken) ?? '';
  }*/

  bool isUserLoggedIn() {
    return _preferences.getBool(isLoggedIn) ?? false;
  }

  Future<void> initiateLogout() async {
    _loginDetail = null;
    await _preferences.clear();
  }
}
