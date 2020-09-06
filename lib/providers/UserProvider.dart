import 'dart:convert';

import 'package:book_store/models/HttpException.dart';
import 'package:book_store/models/UserToken.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  var isLoading = false;
  var isLogin = true;
  static const String _LOGIN="verifyPassword";
  static const String _SIGN_UP="signupNewUser";

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
    isLoading = true;
    notifyListeners();

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
      isLoading = false;
      notifyListeners();
      if (responseData["error"] != null)
        throw HttpException(responseData["error"]["message"]);
      else if(urlSegment==_SIGN_UP)
        changeLoginStatus();
    saveUserToken(responseData);
  }

  UserToken saveUserToken(map){
    final x = UserToken(map['idToken'],map['userId'],map['expiryDate']);
    print(("Token: ${x.token}"));
    return x;
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
