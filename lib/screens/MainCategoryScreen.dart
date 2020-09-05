import 'package:book_store/providers/CategoriesProvider.dart';
import 'package:book_store/widgets/MainCategoryItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<CategoriesProvider>(context);
    final categoriesList = categoriesData.categoryItems;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 20,
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 20
      ),
     itemBuilder: (ctx, i) => MainCategoryItem(categoriesList[i]),
      itemCount: categoriesList.length,
    );
  }
}
