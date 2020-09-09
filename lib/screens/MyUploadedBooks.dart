import 'package:book_store/providers/BooksProvider.dart';
import 'package:book_store/widgets/AppDrawer.dart';
import 'package:book_store/widgets/EmptyWidget.dart';
import 'package:book_store/widgets/GridViewBuilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyUploadedBooks extends StatefulWidget {
  static const ROUTE_NAME = "MyUploadedBooks";

  @override
  _MyUploadedBooksState createState() => _MyUploadedBooksState();
}

class _MyUploadedBooksState extends State<MyUploadedBooks> {
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    _getMyBooks();
    super.didChangeDependencies();
  }

  void _changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void _getMyBooks() async{
    _changeLoading();
    try {
      await Provider.of<BooksProvider>(context, listen: false).fetchMyBooks();
    } catch (error) {
      print(error);
    }
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("My Books"),
      ),
      body: Container(
        child: Consumer<BooksProvider>(
          builder: (ctx, data, _) => isLoading
              ? Center(child: CircularProgressIndicator(),)
              : data.ownBooksList.isEmpty
                  ? EmptyWidget()
                  : GridViewBuilder(
                      isPublished: false,
                      isMainCategory: false,
                      list: data.ownBooksList,
                    ),
        ),
      ),
    );
  }
}
