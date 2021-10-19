import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
              ],
            ),
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
        title: Text(
          "Search",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: ListView(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 40,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      hintText: 'Vehicles Number',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 40,
                width: 350,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(8.0)),
                child: DropdownButton(
                  isExpanded: true,
                  items: [],
                  underline: Container(
                    color: Colors.transparent,
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                    size: 40,
                  ),
                  hint: Center(
                    child: Text(
                      "Owner Type",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 40,
                width: 350,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(8.0)),
                child: DropdownButton(
                  isExpanded: true,
                  items: [],
                  underline: Container(
                    color: Colors.transparent,
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                    size: 40,
                  ),
                  hint: Center(
                    child: Text(
                      "Vehicle Type",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 40,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      hintText: 'Vehicles Reg Number',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 40,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      hintText: 'Driver Name',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 40,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      hintText: 'Driver Mobile Number',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 40,
                width: 350,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(8.0)),
                child: DropdownButton(
                  isExpanded: true,
                  items: [],
                  underline: Container(
                    color: Colors.transparent,
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                    size: 40,
                  ),
                  hint: Center(
                    child: Text(
                      "Transfer Station",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 40,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      hintText: 'Land Mark',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 40,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      hintText: 'Circle',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 40,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      hintText: 'Zone',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.black)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 40,
                width: 350,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(8.0)),
                child: DropdownButton(
                  isExpanded: true,
                  items: [],
                  underline: Container(
                    color: Colors.transparent,
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                    size: 40,
                  ),
                  hint: Center(
                    child: Text(
                      "Ward",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(15.0)),
                height: 120,
                width: 340,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                        backgroundColor: Colors.black,
                        onPressed: () {},
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 40,
                        )),
                    FloatingActionButton(
                        backgroundColor: Colors.black,
                        onPressed: () {},
                        child: Icon(
                          Icons.picture_in_picture_sharp,
                          color: Colors.white,
                          size: 40,
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 200,
                child: FlatButton(
                    height: 30,
                    minWidth: 100,
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFAD1457), Color(0xFFAD801D9E)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
