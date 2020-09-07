import 'package:book_store/providers/CategoriesProvider.dart';
import 'package:book_store/widgets/AppDrawer.dart';
import 'package:book_store/widgets/GridViewBuilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCategoryScreen extends StatefulWidget {
  static const String ROUTE_NAME = "MainCategoryScreen";

  @override
  _MainCategoryScreenState createState() => _MainCategoryScreenState();
}

class _MainCategoryScreenState extends State<MainCategoryScreen> {
  @override
  void initState() {
    Provider.of<CategoriesProvider>(context, listen: false).fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
