import 'dart:ui';

import 'package:book_store/models/Categories.dart';
import 'package:book_store/screens/SpecificCategory.dart';
import 'package:flutter/material.dart';

class MainCategoryItem extends StatelessWidget {
  final Categories category;
  MainCategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(SpecificCategory.ROUTE_NAME, arguments: category.id);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Card(
            child: Stack(
              fit: StackFit.expand,
              children: [
                  Image.network(
                    category.imageUrl,fit: BoxFit.cover,
                ),
                BackdropFilter(
                  child: Container(
                    color: Colors.black12,
                  ),
                  filter: ImageFilter.blur(sigmaY: 1.5, sigmaX: 1.5),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    width: double.infinity,
                    child: Text(
                      category.title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    color: Colors.black54,
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}
