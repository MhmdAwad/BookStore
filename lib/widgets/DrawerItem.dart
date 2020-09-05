import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function function;

  DrawerItem(this.icon, this.text, this.function);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
          width: double.infinity,
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
          ])),
    );
  }
}
