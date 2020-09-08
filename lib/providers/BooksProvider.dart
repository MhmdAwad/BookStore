import 'package:book_store/models/Books.dart';
import 'package:book_store/models/Categories.dart';
import 'package:book_store/models/HttpException.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BooksProvider with ChangeNotifier {
  bool isLoading = false;
  List<Books> _booksList = [];
  String _token;
  String _userID;

  List<Categories> _spinnerItems = [];

  void update(token, userId, categoryItems){
    this._token = token;
    this._userID = userId;
    this._spinnerItems = categoryItems;
  }

  String get userId {
      return _userID;
  }
  Future<void> fetchBooksByCategory(String categoryID) async {
    String url ='https://bookstore-fbf66.firebaseio.com/books.json?auth=$_token&orderBy="categoryId"&equalTo="$categoryID"';
      final response = await http.get(url);
      final fetchData = json.decode(response.body) as Map<String, dynamic>;
      if (fetchData["error"] != null)
        throw HttpException(fetchData["error"]);
      _booksList.clear();
      fetchData.forEach((key, value) {
        _booksList.add(Books.fromJson(value));
      });
      if(_booksList.isEmpty)
        throw HttpException("no data");
      notifyListeners();
  }

  Future<void> uploadNewBook(Books book, String category) async {
    isLoading = true;
    notifyListeners();
    http.Response res = await http.put(
        "https://bookstore-fbf66.firebaseio.com/pinned/${book.bookTitle}.json?auth=$_token",
        body: jsonEncode(book.toJson()));
    isLoading = false;
    notifyListeners();
    final checkErrors = json.decode(res.body)['error'];
    if(checkErrors != null)
       throw HttpException(checkErrors);
  }

  List<String> get spinnerTitles{
    List<String> _spinnerTitles =[];
    _spinnerItems.forEach((e) {
      _spinnerTitles.add(e.title);
    });
    return _spinnerTitles;
  }
  String spinnerItemId(String cat){
    return _spinnerItems.firstWhere((element) => element.title == cat).id;
  }

  List<Books> get booksList {
    return [..._booksList];
  }


}
