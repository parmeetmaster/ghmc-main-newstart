import 'package:flutter/material.dart';
import 'package:ghmc/globals/constants.dart';

abstract class FAppBar {
  static getCommonAppBar({String title = "", TextStyle? textStyle}) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: main_color,
          ),
        ),
      ),
      title: Text('${title}',style: textStyle,),
    );
  }

  static getAppBarWithPlus({String title = "",Function? onclick}) {
    return AppBar(
      actions: [
       IconButton(onPressed: (){
         onclick!();
       }, icon:Icon(Icons.add)),
        SizedBox(width: 10,)
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: main_color,
          ),
        ),
      ),
      title: Text('${title}'),
    );
  }

  static getAppBarWithSearch({String title = "",Function? onclick}) {
    return AppBar(
      actions: [
        IconButton(onPressed: (){
          onclick!();
        }, icon:Icon(Icons.search)),
        SizedBox(width: 10,)
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: main_color,
          ),
        ),
      ),
      title: Text('${title}'),
    );
  }

}
