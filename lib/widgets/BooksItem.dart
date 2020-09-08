import 'dart:ui';

import 'package:book_store/models/Books.dart';
import 'package:book_store/screens/BookDetails.dart';
import 'package:flutter/material.dart';

class BooksItem extends StatelessWidget {
  final Books book;
  final bool isPublished;
  BooksItem(this.book, this.isPublished);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(BookDetails.ROUTE_NAME, arguments: {
          "book":book,
          "isPublished":isPublished
        });
      },
      child: Hero(
        tag: book.bookId,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Card(
            elevation: 3,
            child: Stack(
              children: [
                Center(
                  child: FadeInImage.assetNetwork(image: book.bookCover, placeholder: "assets/images/placeholder.png",
                  fit: BoxFit.fill,),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2,horizontal: 4),
                    color: Colors.black54,
                    child: Column(
                      children: [
                        Text(
                          book.bookTitle,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(height: 2,),
                        Row(
                          children: [
                            Image.asset("assets/images/star.png", height: 16,width: 16,),
                            SizedBox(width: 10,),
                            Text("${book.rating}/5", style: TextStyle(color: Colors.orangeAccent, fontSize: 16),)
                          ],),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
