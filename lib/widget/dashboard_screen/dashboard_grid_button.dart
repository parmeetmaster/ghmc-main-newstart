import 'package:flutter/material.dart';

class DashBoardItemButton extends StatefulWidget {
  List<Color>? color_grid;
  String? header;
  String? amount;

  DashBoardItemButton({Key? key, this.color_grid, this.header, this.amount})
      : super(key: key);

  @override
  _DashBoardItemButtonState createState() => _DashBoardItemButtonState();
}

class _DashBoardItemButtonState extends State<DashBoardItemButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: EdgeInsets.only(right: 7),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.header ?? "",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.amount ?? "",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(colors: widget.color_grid!)),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Icon(
            Icons.download,
            color: Colors.white,
            size: 25,
          ),
        ),
      ],
    );
  }
}
