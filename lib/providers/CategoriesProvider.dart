import 'dart:convert';

import 'package:book_store/models/Categories.dart';
import 'package:book_store/models/User.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class CategoriesProvider with ChangeNotifier {
   String _token;
   String _userID;
   User _user;
   String values;
   void update(token, userId, user){
     this._token = token;
     this._userID = userId;
     this._user = user;
   }
   User get user => _user;
   String get userID => _userID;
   String get token => _token;
  List<Categories> _categoriesList = [];

  void getPinnedList() async{
    final response = await http.get("https://bookstore-fbf66.firebaseio.com/pinned.json?auth=$_token",);
    print(response.body);
  }
  void fetchCategories() async{
      final response = await http.get("https://bookstore-fbf66.firebaseio.com/categories/.json?auth=$_token",);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      _categoriesList.clear();
      extractedData.forEach((key, value) {
        _categoriesList.add(Categories(key,value['catID'], imageUrl: value['catImage']));
      });
      notifyListeners();
  }

  List<Categories> get categoryList {
    return [..._categoriesList];
  }


}