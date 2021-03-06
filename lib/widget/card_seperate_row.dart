import 'package:flutter/material.dart';

class CardSeperateRow extends StatelessWidget {
  String? keyval;
  String? value;
  double? fontsize;

  CardSeperateRow(this.keyval, this.value, {this.fontsize = 18});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            "${keyval}",
            style: TextStyle(fontSize: fontsize),
          ),
        ),
        SizedBox(
          width: 15,
          child: Text(":", style: TextStyle(fontSize: 22)),
        ),
        Expanded(
          flex: 5,
          child: Text(
            "${value ?? ""}",
            style: TextStyle(fontSize: fontsize),
          ),
        ),
      ],
    );
  }
}
