import 'package:book_store/models/Books.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BooksProvider with ChangeNotifier {
  List<Books> _booksList = [
    Books(
      "100",
      "دائره الموت",
      "Mohmed",
      "10064",
      0,
      0,
      "https://booksdrive.net/kutub/%D8%AF%D8%A7%D8%A6%D8%B1%D8%A9-%D8%A7%D9%84%D9%85%D9%88%D8%AA-kutub-pdf.net.pdf",
      "https://www.kutub-pdf.net/assets/bimgs/kutub-pdf.net_xoknqau.jpeg",
    ),
    Books(
      "200",
      "حكايات بيتر بيشوب",
      "Mohmed",
      "10022",
      0,
      0,
      "https://booksdrive.net/kutub/%D8%AD%D9%83%D8%A7%D9%8A%D8%A7%D8%AA-%D8%A8%D9%8A%D8%AA%D8%B1-%D8%A8%D9%8A%D8%B4%D9%88%D8%A8-kutub-pdf.net.pdf",
      "https://www.kutub-pdf.net/assets/bimgs/kutub-pdf.net_I53fS.jpg",
    ),
    Books(
      "366",
      "داو إلا قليلًا",
      "Mohmed",
      "10038",
      0,
      0,
      "https://booksdrive.net/kutub/%D8%AF%D8%A7%D9%88-%D8%A5%D9%84%D8%A7-%D9%82%D9%84%D9%8A%D9%84-%D8%A7-kutub-pdf.net.pdf",
      "https://www.kutub-pdf.net/assets/bimgs/kutub-pdf.net_cNwexl4.jpeg",
    ),
  ];

  void pushBooks() {
    booksList.map((item) {
      http.post("https://bookstore-fbf66.firebaseio.com/category.json",
          body: jsonEncode(item.toJson()));
    }).toList();
  }

  List<Books> get booksList {
    return [..._booksList];
  }
}
