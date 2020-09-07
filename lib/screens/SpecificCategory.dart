import 'package:book_store/models/HttpException.dart';
import 'package:book_store/providers/BooksProvider.dart';
import 'package:book_store/widgets/GridViewBuilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecificCategory extends StatefulWidget {
  static const String ROUTE_NAME = "SpecificCategory";

  @override
  _SpecificCategoryState createState() => _SpecificCategoryState();
}

class _SpecificCategoryState extends State<SpecificCategory> {
  bool errorOccurred = false;
  bool isInit = true;
  String _categoryID;
  String _categoryTitle;

  @override
  void didChangeDependencies() {
    if (isInit) {
      fetchData();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  void changeError() {
    setState(() {
      errorOccurred = !errorOccurred;
    });
  }

  void fetchData() async {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    _categoryID = args['id'];
    _categoryTitle = args['title'];

    try {
      await Provider.of<BooksProvider>(context, listen: false)
          .fetchBooksByCategory(_categoryID);
    } catch (error) {
      changeError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_categoryTitle)),
      body: Consumer<BooksProvider>(
          builder: (ctx, data, _) => data.booksList.isEmpty
              ? Text(
                  "Empty",
                  textAlign: TextAlign.center,
                )
              : GridViewBuilder(
                  isMainCategory: false,
                  list: data.booksList,
                )),
    );
  }
}
