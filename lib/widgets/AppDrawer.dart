import 'package:book_store/widgets/DrawerItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 160,
            color: Colors.amber,
            alignment: Alignment.center,
            child: Text(
              "Book Store",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),),
            ),
          SizedBox(height: 20,),
          DrawerItem(Icons.book, "My Books"),
          Divider(),
          DrawerItem(Icons.file_upload, "Upload Book"),
          Divider(),
          DrawerItem(Icons.settings, "Settings"),
          Divider(),
          DrawerItem(Icons.exit_to_app, "Sign out"),
        ],
      ),
    );
  }
}
