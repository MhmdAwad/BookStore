import 'package:book_store/models/Categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainCategoryItem extends StatelessWidget {
  final Categories category;


  MainCategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Stack(
        children: [
          Image.network(
            category.imageUrl,
          ),
          Positioned(
            child: Container(
              child: Text(
                category.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
