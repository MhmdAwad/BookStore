import 'package:book_store/models/HttpException.dart';
import 'package:book_store/providers/BooksProvider.dart';
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

  @override
  void didChangeDependencies() {
    if(isInit){
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

  void fetchData()async{
    String categoryID = ModalRoute.of(context).settings.arguments;
    try {
      await Provider.of<BooksProvider>(context, listen: false)
          .fetchBooksByCategory(categoryID);
    }catch (error) {
      print("ZXXXXXXXXXXXXXXX $error");
      changeError();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<BooksProvider>(
          builder: (ctx, data, _) => Text(
                errorOccurred?"ERROR":"${data.booksList.length}",
                textAlign: TextAlign.center,
              )),
    );
  }
}
