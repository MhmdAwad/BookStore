
import 'package:book_store/models/Categories.dart';
import 'package:flutter/cupertino.dart';

class CategoriesProvider with ChangeNotifier{

  List<Categories> _categoriesList = [
    Categories(
      "https://img.freepik.com/free-vector/frightening-halloween-realistic-background_33099-1052.jpg?size=626&ext=jpg",
      "روايات رعب",
    ),
    Categories(
      "https://assets.entrepreneur.com/content/3x2/2000/20191219170611-GettyImages-1152794789.jpeg",
      "راويات عربية",
    ),
    Categories(
      "https://img.jakpost.net/c/2019/03/02/2019_03_02_66706_1551461528._large.jpg",
      "روايات أجنبية",
    ),
    Categories(
      "https://cdn.elearningindustry.com/wp-content/uploads/2016/05/top-10-books-every-college-student-read-1024x640.jpeg",
      "روايات مترجمة",
    ),
    Categories(
      "https://churchdownbookfair.files.wordpress.com/2013/02/love-books-cover.jpg",
      "روايات رومانسية",
    ),
    Categories(
      "https://images.ctfassets.net/cnu0m8re1exe/4KwrJVfCGeyOKwm8PS2tjI/30026753d97e3b41a50560063126ded8/shutterstock_135114548.jpg",
      "كتب إسلامية",
    ),
  ];

  List<Categories> get categoryItems{
    return [..._categoriesList];
  }


}