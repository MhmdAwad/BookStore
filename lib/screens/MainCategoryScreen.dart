import 'package:book_store/providers/CategoriesProvider.dart';
import 'package:book_store/widgets/MainCategoryItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCategoryScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<CategoriesProvider>(context, listen: false);
    final categoriesList = categoriesData.categoryItems;
    return Scaffold(
      appBar: AppBar(title: Text("All Categories"),),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 10
        ),
       itemBuilder: (ctx, i) => MainCategoryItem(categoriesList[i]),
        itemCount: categoriesList.length,
      ),
    );
  }
}
