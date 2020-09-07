import 'package:book_store/screens/SpecificCategory.dart';
import 'package:flutter/material.dart';

import 'MainCategoryItem.dart';

class GridViewBuilder extends StatelessWidget {
  final bool isMainCategory;
  final List<dynamic> list;

  GridViewBuilder({@required this.isMainCategory, this.list});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 10
      ),
      itemBuilder: (ctx, i) => isMainCategory? MainCategoryItem(list[i]): SpecificCategory(),
      itemCount: list.length,
    );
  }
}
