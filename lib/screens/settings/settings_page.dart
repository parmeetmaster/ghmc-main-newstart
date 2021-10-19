import 'package:flutter/material.dart';
import 'package:ghmc/screens/terms_condition/terms_and_conditions_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isInstructionView = false;

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
                Icons.keyboard_backspace,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "Settings",
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.list_alt,
                color: Colors.pink,
                size: 25,
              ),
              title: Text(
                "Terms and Conditions",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
                size: 25,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (TermsAndConditions()),
                    ));
              },
            ),
            Divider(
              color: Colors.black,
              height: 2,
            ),
            ListTile(
              leading: Icon(
                Icons.phonelink_lock,
                color: Colors.pink,
                size: 25,
              ),
              title: Text(
                "Privacy Policy",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
                size: 25,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (TermsAndConditions()),
                    ));
              },
            ),
            Divider(
              color: Colors.black,
              height: 2,
            ),
            ListTile(
              leading: Icon(
                Icons.notification_important,
                color: Colors.pink,
                size: 25,
              ),
              title: Text(
                "Notifications",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              trailing: Switch(
                onChanged: (val) {
                  setState(() {
                    isInstructionView = val;
                  });
                },
                value: isInstructionView,
                activeColor: Colors.pink,
              ),
            ),
            Divider(
              color: Colors.black,
              height: 2,
            ),
            ListTile(
              leading: Icon(
                Icons.web_rounded,
                color: Colors.pink,
                size: 25,
              ),
              title: Text(
                "Languages",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
                size: 25,
              ),
              onTap: () {},
            ),
            Divider(
              color: Colors.black,
              height: 2,
            ),
            ListTile(
              leading: Icon(
                Icons.power_settings_new,
                color: Colors.pink,
                size: 25,
              ),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
                size: 25,
              ),
              onTap: () {},
            ),
            Divider(
              color: Colors.black,
              height: 2,
            )
          ],
        ));
  }
}
