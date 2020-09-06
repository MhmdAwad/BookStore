import 'package:book_store/models/Categories.dart';
import 'package:flutter/material.dart';


class CategoriesProvider with ChangeNotifier{
//  final String _token;
//  final String _userID;
//  CategoriesProvider(this._token, this._userID);

  List<Categories> _categoriesList = [
    Categories(
      0,
      "https://img.freepik.com/free-vector/frightening-halloween-realistic-background_33099-1052.jpg?size=626&ext=jpg",
      "Horror Novel",
    ),
    Categories(
      1,
      "https://assets.entrepreneur.com/content/3x2/2000/20191219170611-GettyImages-1152794789.jpeg",
      "Arabic Novels",
    ),
    Categories(
      2,
      "https://img.jakpost.net/c/2019/03/02/2019_03_02_66706_1551461528._large.jpg",
      "Foreign Novels",
    ),
    Categories(
      3,
      "https://cdn.elearningindustry.com/wp-content/uploads/2016/05/top-10-books-every-college-student-read-1024x640.jpeg",
      "Translated Novels",
    ),
    Categories(
      4,
      "https://churchdownbookfair.files.wordpress.com/2013/02/love-books-cover.jpg",
      "Romantic Novels",
    ),
    Categories(
      5,
      "https://images.ctfassets.net/cnu0m8re1exe/4KwrJVfCGeyOKwm8PS2tjI/30026753d97e3b41a50560063126ded8/shutterstock_135114548.jpg",
      "Islamic Books",
    ),
  ];

  List<Categories> get categoryItems{
    return [..._categoriesList];
  }


}