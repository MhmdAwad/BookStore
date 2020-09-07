import 'package:book_store/providers/CategoriesProvider.dart';
import 'package:book_store/widgets/AppDrawer.dart';
import 'package:book_store/widgets/GridViewBuilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCategoryScreen extends StatelessWidget {
  static const String ROUTE_NAME = "MainCategoryScreen";

  @override
  Widget build(BuildContext context) {
    Provider.of<CategoriesProvider>(context, listen: false).fetchCategories();
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("All Categories"),
        ),
        body: Consumer<CategoriesProvider>(
          builder: (ctx, data, _) => GridViewBuilder(
            isMainCategory: true,
            list: data.categoryList,
          ),
        ));
  }
}
