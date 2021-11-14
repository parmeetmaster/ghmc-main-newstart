import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ghmc/model/covid_form_model.dart';
import 'package:intl/intl.dart';
import 'package:ghmc/util/utils.dart';

class CovidFormData extends StatefulWidget {
  CovidFormData({Key? key}) : super(key: key);

  @override
  State<CovidFormData> createState() => _CovidFormDataState();
}

class _CovidFormDataState extends State<CovidFormData> {
  int activecell = 0;
  static List<CovidSubFormModel> covidModel = [];
  List<Widget> subForms = [];
  TextStyle hintStyle = TextStyle(fontSize: 14);
  double fontSize = 14;
  Timer? mtimer;

  @override
  void initState() {
    super.initState();
    covidModel = []; //todo reove when not required

    for (int i = 0; i < 1; i++) {
      covidModel.add(CovidSubFormModel());
    }
  }

  @override
  void dispose() {
    mtimer!.cancel();
    covidModel = []; //todo reove when not required
    super.dispose();
  }

  TextEditingController firstdose = new TextEditingController();
  TextEditingController seconddose = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    firstdose.text = covidModel[activecell].firstDostDate ?? "";
    seconddose.text = covidModel[activecell].secondDoseDate ?? "";
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...covidModel
                  .mapIndexed((e, index) => _getNumberBox(index, activecell)),
              //  _getNumberBox(2),
              getAddMore()
            ],
          ),

          ...covidModel.mapIndexed((e, i) => activecell == i
              ? Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      child: Row(
                        children: [
                          Text(
                            "Submit Member ${activecell + 1} Detail",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            icon: Icon(Icons.cancel),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                covidModel.removeAt(activecell);
                              });
                            },
                          )
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    //name
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Name",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: TextFormField(
                                  initialValue: covidModel[activecell].name,
                                  onChanged: (s) {
                                    covidModel[activecell].name = s;
                                  },
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: hintStyle,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "Type name here..."),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //gender
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Gender ",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: DropdownButton<String>(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Select Gender'),
                                    isExpanded: true,
                                    value: covidModel[activecell].gender,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: ["Male", "Female"]
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text("${value}"),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      setState(() {
                                        covidModel[activecell].gender =
                                            newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //age
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Age",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: TextFormField(
                                  initialValue: covidModel[activecell].age,
                                  onChanged: (s) {
                                    covidModel[activecell].age = s;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: hintStyle,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "Type Age here..."),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //adhhaar
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Adhaar",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: TextFormField(
                                  initialValue: covidModel[activecell].aadhar,
                                  onChanged: (s) {
                                    covidModel[activecell].aadhar = s;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: hintStyle,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "Type Adhaar here..."),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //vaccination Type
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Vaccination Type ",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: DropdownButton<String>(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Select Vaccination'),
                                    isExpanded: true,
                                    value: covidModel[activecell].vaccineType,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: ["Covaxin", "Covi-Shield"]
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text("${value}"),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      setState(() {
                                        covidModel[activecell].vaccineType =
                                            newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //First Dose
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Is first Dose Completed ",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: DropdownButton<String>(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Select Status'),
                                    isExpanded: true,
                                    value:
                                        covidModel[activecell].firstDoseYesNo,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: ["Yes", "No"]
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text("${value}"),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      setState(() {
                                        covidModel[activecell].firstDoseYesNo =
                                            newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //dose 1 date
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Dose 1 date",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: TextFormField(
                                  controller: firstdose,
                                  //initialValue:  covidModel[activecell].firstDostDate,
                                  onTap: () async {
                                    await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime.now(),
                                    ).then((value) async {
                                      setState(() {
                                        if (value == null) return;
                                        firstdose.text =
                                            "${value.day.toString()}-${value.month.toString()}-${value.year.toString()}";
                                        covidModel[activecell].firstDostDate =
                                            "${value.day.toString()}-${value.month.toString()}-${value.year.toString()}";
                                      });
                                    });
                                  },
                                  keyboardType: TextInputType.none,
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: hintStyle,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "Select date here..."),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Second dose
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Is Second Dose Completed ",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: DropdownButton<String>(
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    hint: Text('Select Status'),
                                    isExpanded: true,
                                    value:
                                        covidModel[activecell].secondDoseYesNo,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 20,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    items: ["Yes", "No"]
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text("${value}"),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      setState(() {
                                        covidModel[activecell].secondDoseYesNo =
                                            newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //dose 2 date
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.20,
                            child: Text(
                              "Dose 2 date",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ),
                          Text(':'),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.90,
                                child: TextFormField(
                                  controller: seconddose,
                                  onTap: () async {
                                    DateTime? time = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime.now(),
                                    ).then((value) async {
                                      setState(() {
                                        if (value == null) return;
                                        /*    seconddose.text =
                                        "${value!.day.toString()}-${value.month.toString()}-${value.year.toString()}";*/
                                        covidModel[activecell].secondDoseDate =
                                            "${value.day.toString()}-${value.month.toString()}-${value.year.toString()}";
                                      });
                                    });
                                  },
                                  // initialValue: covidModel[activecell].firstDostDate,
                                  onChanged: (s) {
                                    //   covidModel[activecell].firstDostDate = s;
                                  },
                                  keyboardType: TextInputType.none,
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: hintStyle,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "Select date here..."),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : SizedBox())

          ///
        ],
      ),
    );
  }

  Widget _getNumberBox(int index, int mactiveCell) {
    return GestureDetector(
      onTap: () {
        setState(() {
          activecell = index;

          print(activecell);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: activecell == index ? Colors.red : Colors.purple,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(child: Text("${index + 1}"))),
      ),
    );
  }

  Widget getAddMore() {
    return GestureDetector(
      onTap: () {
        setState(() {
          covidModel.add(new CovidSubFormModel());
        });
      },
      child: Container(
        height: 30,
        decoration: BoxDecoration(color: Colors.purple),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.exposure_plus_1,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Add Member")
            ],
          ),
        ),
      ),
    );
  }
}
