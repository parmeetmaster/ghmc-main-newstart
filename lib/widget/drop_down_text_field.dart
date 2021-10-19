import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  String m_hintText;
  String? m_helperText;
  String m_labelText;
  IconData? icon;
  TextStyle? hintstyle;
  List<String> items;
  Function? onselected;
  String? selected;

  TextEditingController? controller;

  DropDown(
      {Key? key,
      this.m_hintText = "",
      this.m_helperText,
      this.m_labelText = "",
      this.controller,
      this.hintstyle,
      this.selected,
      this.onselected,
      required this.items,
      this.icon})
      : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      iconSize: 0,
      //icon: Icon(Icons.location_city),
      decoration: new InputDecoration(
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.teal)),
        hintText: widget.m_hintText,
        helperText: widget.m_helperText,
        labelText: widget.m_labelText,
        helperStyle: widget.hintstyle,
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
              )
            : null,
        prefixText: ' ',
      ),
      value: widget.selected,
      items: widget.items
          .map((label) => DropdownMenuItem(
                child: Text(label),
                value: label,
              ))
          .toList(),
      onChanged: (value) {
        setState(() => widget.onselected!(value));
      },
    );
  }
}
