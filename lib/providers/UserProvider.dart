import 'dart:convert';

import 'package:book_store/models/HttpException.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  var isLoading = false;
  var isLogin = true;
  String _token ;
  String _userID;
  DateTime _expireDate;
  static const String _LOGIN="verifyPassword";
  static const String _SIGN_UP="signupNewUser";

  String get token {
    if (_expireDate != null &&
        _expireDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userID;
  }

  void changeLoginStatus() {
    isLogin = !isLogin;
    notifyListeners();
  }

  Future<void> _auth({
    String urlSegment,
    String name,
    String email,
    String pass,
  }) async {
    _loading();
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyC8t22p96pJ1RCWwTcXhfUF5l_IWpGdVBw';

      final response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": pass,
            "displayName": name,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
      _loading();
      if (responseData["error"] != null)
        throw HttpException(responseData["error"]["message"]);
      else if(urlSegment==_SIGN_UP)
        changeLoginStatus();
    _saveUserToken(responseData);
  }


  Future<bool> tryAutoLogin()async{
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final data = json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = data['token'];
    _userID = data['userId'];
    _expireDate = DateTime.parse(data['expiredDate']);
    notifyListeners();
    return true;
  }

  void _loading(){
    isLoading = !isLoading;
    notifyListeners();
  }

  void _saveUserToken(map)async{
    if(map['idToken'] == null)
      return;
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(
      {
        'token': map['idToken'],
        'userId': map['localId'],
        'expiredDate': DateTime.now().add(Duration(seconds: int.parse(map['expiresIn']))).toIso8601String(),
      },
    );
    prefs.setString("userData", userData);
    tryAutoLogin();
  }

  Future<void> login(String email, String pass) async{
      return _auth(urlSegment: _LOGIN, email: email, pass: pass);
  }

  Future<void> signUp(String name, String email, String pass) async {
    return _auth(
        urlSegment: _SIGN_UP, email: email, pass: pass, name: name);
  }

  String authError(String error) {
    if (error.toString().contains('EMAIL_EXISTS'))
      return 'This email address is already in use.';
     else if (error.toString().contains('INVALID_EMAIL'))
      return 'This is not a valid email address';
     else if (error.toString().contains('WEAK_PASSWORD'))
      return 'This password is too weak.';
     else if (error.toString().contains('EMAIL_NOT_FOUND'))
      return 'Could not find a user with that email.';
     else if (error.toString().contains('INVALID_PASSWORD'))
      return 'Invalid password.';
     else
      return "Authentication failed";
  }
}
