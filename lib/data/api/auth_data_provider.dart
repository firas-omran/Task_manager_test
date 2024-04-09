import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/constants.dart';
import '../../../utils/exception_handler.dart';

class AuthDataProvider {
  SharedPreferences? prefs;

  AuthDataProvider(this.prefs);

  Future<String> logIn(String email, String password) async {
    try {
      String userUrl = Constants.baseUrl + 'login';
      Response response = await post(Uri.parse(userUrl), body: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        String token = jsonDecode(response.body)['token'];
        await prefs!.setString(Constants.tokenKey, token);
        return token;
      }
      return '';
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<bool> hasToken() async {
    try {
      final String? savedToken = prefs!.getString(Constants.tokenKey);
      if (savedToken != null && !savedToken.isEmpty) {
        return true;
      } else
        return false;
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> setToken(String token) async {
    try {
      await prefs!.setString(Constants.tokenKey, token);
    } catch (exception) {
      throw handleException(exception);
    }
  }

  Future<void> deleteToken() async {
    try {
      await prefs!.clear();
    } catch (exception) {
      throw handleException(exception);
    }
  }
}
