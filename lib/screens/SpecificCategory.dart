import 'package:book_store/providers/BooksProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecificCategory extends StatelessWidget {
  static const String ROUTE_NAME = "SpecificCategory";

  @override
  Widget build(BuildContext context) {
    String category = ModalRoute.of(context).settings.arguments;
    final booksProvider = Provider.of<BooksProvider>(context, listen: false);
    final booksList = Provider.of<BooksProvider>(context, listen: false).booksList;

    return Container(
      child: Text(booksList[0].bookTitle, textAlign: TextAlign.center,),
    );
  }
}
