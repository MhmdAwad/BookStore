import 'dart:convert';

import 'package:book_store/models/Categories.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class CategoriesProvider with ChangeNotifier {
   String _token;
   String _userID;
   void update(token, userId ){
     this._token = token;
     this._userID = userId;
   }

  List<Categories> _categoriesList = [];

  void fetchCategories() async{
      final response = await http.get("https://bookstore-fbf66.firebaseio.com/categories/.json?auth=$_token",);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      _categoriesList.clear();
      extractedData.forEach((key, value) {
        _categoriesList.add(Categories(value['catID'], value['catImage'], key));
      });
      notifyListeners();
  }

  List<Categories> get categoryList {
    return [..._categoriesList];
  }


}