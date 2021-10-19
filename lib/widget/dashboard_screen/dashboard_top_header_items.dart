import 'package:flutter/material.dart';

class DashBordHeaderItem extends StatelessWidget {
  IconData? icon;
  String? header;
  List<Color>? color;

  DashBordHeaderItem({Key? key, this.header, this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            header ?? "",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 7,
          ),
          if (icon != null)
            Icon(
              icon,
              color: Colors.white,
              size: 25,
            )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(colors: color ?? [])),
    );
  }
}
