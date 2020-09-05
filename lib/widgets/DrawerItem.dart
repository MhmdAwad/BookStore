import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;

  DrawerItem(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Icon(icon),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.headline6,
          ),
        ]));
  }
}
