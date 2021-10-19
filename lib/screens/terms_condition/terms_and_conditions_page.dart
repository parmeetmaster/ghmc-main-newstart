import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFFAD1457),
                  Color(0xFFAD801D9E),
                ]),
          ),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("Terms And Conditions"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Container(
            child: Text(
              "Description Terms of service are the legal agreements between a "
              "service provides and a person who wants to use that service. The "
              "person must agree to abide by the terms of service in order to use "
              "the offered service. Terms of service can also be merely a "
              "disclaimer, especially regarding the use of websites. "
              "",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
