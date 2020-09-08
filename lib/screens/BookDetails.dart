import 'package:book_store/models/Books.dart';
import 'package:book_store/providers/CategoriesProvider.dart';
import 'package:book_store/screens/PDFPreviewScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatelessWidget {
  static const String ROUTE_NAME = "BookDetails";

  List<Widget> ratingBar(int rating) {
    List<Widget> list = [];
    for (int i = 1; i <= 5; i++) {
      list.add(Image.asset(
        "assets/images/${i <= rating ? "star" : "favorites"}.png",
        height: 20,
        width: 20,
      ));
      list.add(SizedBox(
        width: 4,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    Books books = ModalRoute.of(context).settings.arguments;
    bool isAdmin =
        Provider.of<CategoriesProvider>(context, listen: false).user.isAdmin;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                books.bookTitle,
              ),
              background: Hero(
                tag: books.bookId,
                child: Image.network(
                  books.bookCover,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Rating: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          ...ratingBar(books.rating),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Image.asset(
                                    "assets/images/book.png",
                                    color: Colors.white,
                                    height: 18,
                                    width: 18,
                                  ),
                                  color: Theme.of(context).accentColor,
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        PDFPreviewScreen.ROUTE_NAME,
                                        arguments: books.bookPDF);
                                  },
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                if (isAdmin)
                                  Column(
                                    children: [
                                      RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: Icon(
                                          Icons.done,
                                          color: Colors.white,
                                        ),
                                        color: Theme.of(context).accentColor,
                                        onPressed: () async {
                                          await Provider.of<CategoriesProvider>(
                                              context,
                                              listen: false)
                                              .pushPinnedBook(books);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                        color: Theme.of(context).accentColor,
                                        onPressed: () async {
                                          await Provider.of<CategoriesProvider>(
                                              context,
                                              listen: false)
                                              .deletePinnedBook(books.bookTitle);
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          "Description: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        alignment: Alignment.centerLeft,
                      ),
                      Text(
                        books.bookDescription,
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
