import 'package:book_store/providers/CategoriesProvider.dart';
import 'package:book_store/widgets/GridViewBuilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinnedBooks extends StatelessWidget {
  static const String ROUTE_NAME ="PinnedBooks";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pinned Books"),),
      body: Consumer<CategoriesProvider>(
        builder: (_, data, child) => GridViewBuilder(
          isMainCategory: false,
          list: data.booksList,
        ),
      ),
    );
  }
}
