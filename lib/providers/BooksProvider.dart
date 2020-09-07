import 'package:book_store/models/Books.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BooksProvider with ChangeNotifier {
  bool isLoading = false;
  List<Books> _booksList = [];

  Future<void> fetchBooksByCategory(int categoryID) async {
    final response = await http.get(
        'https://bookstore-fbf66.firebaseio.com/books.json?orderBy="categoryId"&equalTo=$categoryID');
    final fetchData = json.decode(response.body) as Map<String, dynamic>;
    _booksList.clear();
    fetchData.forEach((key, value) {
      _booksList.add(Books.fromJson(value));
    });
    notifyListeners();
    print(fetchData);
  }

  Future<void> uploadNewBook(Books book, String category) async {
    isLoading = true;
    notifyListeners();
    http.Response res = await http.put(
        "https://bookstore-fbf66.firebaseio.com/books/${book.bookTitle}.json",
        body: jsonEncode(book.toJson()));
    isLoading = false;
    notifyListeners();
    if (res.statusCode != 200) throw Exception();
  }

  List<Books> get booksList {
    return [..._booksList];
  }
}
