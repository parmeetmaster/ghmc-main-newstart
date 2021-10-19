import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  Function? onclick;
  String? title;
  double? fontsize;
  double? height;
  double? padding;

  GradientButton(
      {this.title = "",
      this.onclick,
      this.height = 30,
      this.fontsize = 20,
      this.padding = 8});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding!),
      child: Container(
        child: TextButton(
            onPressed: () {
              if (onclick != null) onclick!();
            },
            child: Text(
              '${title!}',
              style: TextStyle(
                color: Colors.white,
                fontSize: fontsize,
                // height: height,
              ),
            )),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFAD1457), Color(0xFFAD801D9E)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.0)),
      ),
    );
  }
}
