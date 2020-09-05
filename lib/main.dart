import 'package:book_store/providers/CategoriesProvider.dart';
import 'package:book_store/screens/MainCategoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(ctx)=> CategoriesProvider(),
      child: MaterialApp(
        title: 'BookStore',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainCategoryScreen(),
      ),
    );
  }
}
