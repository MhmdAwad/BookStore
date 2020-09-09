import 'dart:ui';

import 'package:book_store/providers/UserProvider.dart';
import 'package:book_store/screens/AuthScreen.dart';
import 'package:book_store/screens/MyUploadedBooks.dart';
import 'package:book_store/screens/UploadBookScreen.dart';
import 'package:book_store/widgets/DrawerItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 160,
            alignment: Alignment.center,
            child: Stack(children: [
              Image.asset("assets/images/book_background.jpg", fit: BoxFit.cover, height: double.infinity, width: double.infinity,),
              BackdropFilter(
                child: Container(
                  color: Colors.black26,
                ),
                filter: ImageFilter.blur(sigmaY: 1.5, sigmaX: 1.5),
              ),
              Center(
                child: Text(
                  "Book Store",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          DrawerItem(Icons.dashboard, "Category", () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          Divider(),
          DrawerItem(Icons.book, "My Books", () {
            Navigator.of(context)
                .pushReplacementNamed(MyUploadedBooks.ROUTE_NAME);
          }),
          Divider(),
          DrawerItem(Icons.file_upload, "Upload Book", () {
            Navigator.of(context)
                .pushReplacementNamed(UploadBookScreen.ROUTE_NAME);
          }),
          Divider(),
          DrawerItem(Icons.settings, "Settings", () {}),
          Divider(),
          DrawerItem(Icons.exit_to_app, "Sign out", () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(AuthScreen.ROUTE_NAME);
            Provider.of<UserProvider>(context, listen: false).logout();
          }),
        ],
      ),
    );
  }
}
