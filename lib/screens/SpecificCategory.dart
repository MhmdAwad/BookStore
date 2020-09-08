import 'package:book_store/providers/BooksProvider.dart';
import 'package:book_store/utils/WidgetStatus.dart';
import 'package:book_store/widgets/EmptyWidget.dart';
import 'package:book_store/widgets/GridViewBuilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecificCategory extends StatefulWidget {
  static const String ROUTE_NAME = "SpecificCategory";

  @override
  _SpecificCategoryState createState() => _SpecificCategoryState();
}

class _SpecificCategoryState extends State<SpecificCategory> {
  bool isInit = true;
  String _categoryID;
  String _categoryTitle;
  WidgetStatus _status = WidgetStatus.LOADING;

  @override
  void didChangeDependencies() {
    if (isInit) {
      fetchData();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  void changeStatus(st) {
    setState(() {
      _status = st;
    });
  }

  void fetchData() async {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    _categoryID = args['id'];
    _categoryTitle = args['title'];

    try {
      changeStatus(WidgetStatus.LOADING);
      await Provider.of<BooksProvider>(context, listen: false)
          .fetchBooksByCategory(_categoryID);
      changeStatus(WidgetStatus.SUCCESS);
    } catch (error) {
      changeStatus(WidgetStatus.FAILED);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_categoryTitle)),
      body: Consumer<BooksProvider>(
          builder: (ctx, data, _) => _status == WidgetStatus.LOADING
              ? Center(child: CircularProgressIndicator())
              : _status == WidgetStatus.FAILED
                  ? EmptyWidget()
                  : GridViewBuilder(
                      isPublished: true,
                      isMainCategory: false,
                      list: data.booksList,
                    )),
    );
  }
}
