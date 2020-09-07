import 'package:book_store/providers/BooksProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecificCategory extends StatelessWidget {
  static const String ROUTE_NAME = "SpecificCategory";

  @override
  Widget build(BuildContext context) {
    int categoryID = ModalRoute.of(context).settings.arguments;
    Provider.of<BooksProvider>(context, listen: false).fetchBooksByCategory(categoryID);

    return Container(
      child: Consumer<BooksProvider>(
          builder: (ctx, data, _) => Text(
                "${data.booksList.length}",
                textAlign: TextAlign.center,
              )),
    );
  }
}
