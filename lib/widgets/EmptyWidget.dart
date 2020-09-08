import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/shelf.png"),
            SizedBox(height: 30,),
            Text("No Books")
          ],
        ),
      ],
    );
  }
}
