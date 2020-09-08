import 'package:book_store/providers/CategoriesProvider.dart';
import 'package:book_store/widgets/AppDrawer.dart';
import 'package:book_store/widgets/GridViewBuilder.dart';
import 'package:book_store/widgets/UploadsNotification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MainCategoryScreen extends StatefulWidget {
  static const String ROUTE_NAME = "MainCategoryScreen";

  @override
  _MainCategoryScreenState createState() => _MainCategoryScreenState();
}

class _MainCategoryScreenState extends State<MainCategoryScreen> {
  @override
  void initState() {
    Provider.of<CategoriesProvider>(context, listen: false).fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
        builder: (ctx, data, _) => Scaffold(
              drawer: AppDrawer(),
              appBar: AppBar(
                actions: [
                  data.user.isAdmin
                      ? UploadsNotification(value: "5",child: IconButton(icon: Icon(Icons.notifications),onPressed: (){},),)
                      : Container()
                ],
                title: Text("All Categories"),
              ),
              body: GridViewBuilder(
                isMainCategory: true,
                list: data.categoryList,
              ),
            ));
  }
}
