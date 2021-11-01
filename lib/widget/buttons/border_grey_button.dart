import 'package:flutter/material.dart';

class BorderedGreyButton extends StatefulWidget {
  Color? spashColor;
  bool? enable;
  Function? onclick;
  final String text;

  BorderedGreyButton(
      {Key? key,
      this.onclick,
      this.spashColor,
      this.enable = false,
      required this.text})
      : super(key: key);

  @override
  _BorderedGreyButtonState createState() => _BorderedGreyButtonState();
}

class _BorderedGreyButtonState extends State<BorderedGreyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onclick!(),
      child: Container(
        child: Center(child:Text(widget.text)),
        height: 50,
        width: 30,
        decoration: BoxDecoration(
            color: widget.enable == null
                ? Colors.grey[300]
                : widget.enable == true
                    ? widget.spashColor
                    : Colors.grey[300],
            border: Border.all(color: Colors.black87, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
    );
  }
}
