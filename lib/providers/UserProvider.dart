import 'dart:async';
import 'dart:convert';

import 'package:book_store/models/HttpException.dart';
import 'package:book_store/models/User.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  var isLogin = true;
  Timer _authTimer;
  User _user;
  static const String _LOGIN = "verifyPassword";
  static const String _SIGN_UP = "signupNewUser";

  User get userData {
    return _user;
  }

  String get token {
    if (_user != null && _user.expireDate != null &&
        _user.expireDate.isAfter(DateTime.now()) &&
        _user.token != null) {
      return _user.token;
    }
    return null;
  }

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _user.userId;
  }

  void changeLoginStatus() {
    isLogin = !isLogin;
    notifyListeners();
  }

  Future<void> _auth(
      {String urlSegment, String name, String email, String pass}) async {
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyC8t22p96pJ1RCWwTcXhfUF5l_IWpGdVBw';

    final response = await http.post(url,
        body: json.encode({
          "email": email,
          "password": pass,
          'returnSecureToken': true,
        }));
    final responseData = json.decode(response.body);
    if (responseData["error"] != null)
      throw HttpException(responseData["error"]["message"]);
    _saveUserData(responseData);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final data =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expireDate = DateTime.parse(data['expiredDate']);
    if (expireDate.isBefore(DateTime.now())) {
      return false;
    }
    _user = new User(
      data["name"],
      data["email"],
      data['token'],
      data['userId'],
      data["isAdmin"],
      DateTime.parse(data['expiredDate']),
    );
    notifyListeners();
    _fetchUserData();
    _autoLogout();
    return true;
  }

  Future<void> login(String email, String pass) async {
    await _auth(urlSegment: _LOGIN, email: email, pass: pass);
  }

  Future<void> signUp(String name, String email, String pass) async {
    await _auth(urlSegment: _SIGN_UP, email: email, pass: pass, name: name);
    addUserInfo(name, email);
    login(email, pass);
  }

  void addUserInfo(String name, String email) async {
    await http.put(
        "https://bookstore-fbf66.firebaseio.com/users/${_user.userId}.json?auth=${_user.token}",
        body: json.encode({
          "id": _user.userId,
          "name": name,
          "email": email,
          "isAdmin": false
        }));
  }

  void _saveUserData(map) async {
    //get user data
    final response = await http.get(
        "https://bookstore-fbf66.firebaseio.com/users/${map['localId']}.json?auth=${map['idToken']}");
    final exData = json.decode(response.body);
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(
      {
        'name': exData["name"],
        'email': exData["email"],
        "isAdmin": exData["isAdmin"],
        'token': map['idToken'],
        'userId': map['localId'],
        'expiredDate': DateTime.now()
            .add(Duration(seconds: int.parse(map['expiresIn'])))
            .toIso8601String(),
      },
    );
    prefs.setString("userData", userData);
    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _user.expireDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
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

  void _fetchUserData() async{
    final response = await http.get(
        "https://bookstore-fbf66.firebaseio.com/users/${_user.userId}/isAdmin.json?auth=${_user.token}");
    final extractData = json.decode(response.body);
    _user.isAdmin = extractData;
    notifyListeners();
  }
}
