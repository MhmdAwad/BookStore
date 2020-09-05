import 'package:book_store/providers/CategoriesProvider.dart';
import 'package:book_store/widgets/GrideViewBuilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<CategoriesProvider>(context, listen: false);
    final categoriesList = categoriesData.categoryItems;
    return Scaffold(
      appBar: AppBar(title: Text("All Categories"),),
      body: GridViewBuilder(isMainCategory: true, list: categoriesList,)
    );
  }
}
