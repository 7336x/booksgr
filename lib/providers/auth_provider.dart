import 'dart:io';
import 'package:booksgr/models/user.dart';
import 'package:booksgr/services/auth_services.dart';
import 'package:booksgr/services/client.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  static const tokenKey = "token";

  String token = "";
  late User user;
  Future<void> signup({required User user}) async {
    token = await AuthServices().signup(user: user);
    setToken(token);
    print(token);
    notifyListeners();
  }

  void signin({required User user}) async {
    token = await AuthServices().signup(user: user);
    setToken(token);
    print(token);
    notifyListeners();
  }

  void setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(tokenKey, token);
  }

  bool isAuth() {
    if (token.isNotEmpty && Jwt.getExpiryDate(token)!.isAfter(DateTime.now())) {
      user = User.fromJson(Jwt.parseJwt(token));
      Client.dio.options.headers[HttpHeaders.authorizationHeader] =
          "Bearer $token";
      return true;
    }
    return false;
  }

  Future<void> initializeAuth() async {
    await _getToken();
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(tokenKey) ?? "";
    notifyListeners();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(tokenKey);
    token = "";

    Client.dio.options.headers.remove(HttpHeaders.authorizationHeader);
    notifyListeners();
  }
}
