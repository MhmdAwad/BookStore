import 'dart:async';
import 'dart:convert';

import 'package:book_store/models/HttpException.dart';
import 'package:book_store/models/User.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  var isLogin = true;
  String _token;
  String _userID;
  DateTime _expireDate;
  Timer _authTimer;
  User _user;
  static const String _LOGIN = "verifyPassword";
  static const String _SIGN_UP = "signupNewUser";

  User get userData {
    return _user;
  }

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
    _token = data['token'];
    _userID = data['userId'];
    _expireDate = DateTime.parse(data['expiredDate']);
    try{
      _user = new User(
        data["name"],
        data["email"],
        _userID,
        data["isAdmin"],
      );
    }catch(err){
      print("eerrrr $err");
    }
    print("ooooooooooooooo ${data["name"]}");
    notifyListeners();
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
        "https://bookstore-fbf66.firebaseio.com/users/$_userID.json?auth=$_token",
        body: json.encode(
            {"id": _userID, "name": name, "email": email, "isAdmin": false}));
  }

  void _saveUserData(map) async {
    _token = map['idToken'];
    _userID = map['localId'];
    _expireDate =
        DateTime.now().add(Duration(seconds: int.parse(map['expiresIn'])));
    //get user data
    final response = await http.get(
        "https://bookstore-fbf66.firebaseio.com/users/$_userID.json?auth=$_token");
    final exData = json.decode(response.body);
//    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(
      {
        'name':exData["name"],
        'email':exData["email"],
        "isAdmin": exData["isAdmin"],
        'token': _token,
        'userId': _userID,
        'expiredDate': _expireDate.toIso8601String(),
      },
    );
    prefs.setString("userData", userData);
  }

  Future<void> logout() async {
    _token = null;
    _userID = null;
    _expireDate = null;
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
    final timeToExpiry = _expireDate.difference(DateTime.now()).inSeconds;
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
}
