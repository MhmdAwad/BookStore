import 'package:book_store/widgets/BooksItem.dart';
import 'package:flutter/material.dart';

import 'MainCategoryItem.dart';

class GridViewBuilder extends StatelessWidget {
  final bool isMainCategory;
  final List<dynamic> list;
  final bool isPublished;

  GridViewBuilder({@required this.isMainCategory, this.list, @required this.isPublished});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisCount: isMainCategory?2:3,
          childAspectRatio: isMainCategory?3/2:3/4.1,
          crossAxisSpacing: 10
      ),
      itemBuilder: (ctx, i) => isMainCategory? MainCategoryItem(list[i]): BooksItem(list[i], isPublished),
      itemCount: list.length,
    );
  }
}
