import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:ghmc/model/covid_form_model.dart';
import 'package:ghmc/provider/add_resident/add_resident_provider.dart';
import 'package:ghmc/screens/add_resident/add_resident.dart';
import 'package:intl/intl.dart';
import 'package:ghmc/util/utils.dart';
import 'package:provider/provider.dart';

typedef List<CovidSubFormModel> CovidTypeDef();
typedef void CovidClearDef();
typedef CovidTypeDefInsert<Null> = void Function(List<CovidSubFormModel>);

class CovidFormController {
  CovidTypeDef? getCovidFamilyData;
  CovidTypeDefInsert? addCovidData;
  CovidClearDef? clear;
  void dispose() {
    //Remove any data that's will cause a memory leak/render errors in here
    addCovidData = null;
    getCovidFamilyData = null;
    clear=null;
  }
}

class CovidFormData extends StatefulWidget {
  CovidFormController? controller;
  RESIDENT_OPR? resident_opr;

  String? uuid;

  CovidFormData({
    Key? key,
    this.controller,
    this.uuid,
    this.resident_opr,
  }) : super(key: key);

  @override
  State<CovidFormData> createState() => _CovidFormDataState();
}

class _CovidFormDataState extends State<CovidFormData> {
  int activecell = 0;

  List<Widget> subForms = [];
  TextStyle hintStyle = TextStyle(fontSize: 14);
  double fontSize = 14;
  Timer? mtimer;

  var vaccinationTypes=[
    "Covaxin",
    "Covishield",
    "Sputnik"
  ];

  List<CovidSubFormModel> getCovidFormData() {
    return provider.covidModel;
  }

  void addCovidData(List<CovidSubFormModel> ls) {
    setState(() {
      provider.covidModel.addAll(ls);
    });
  }

  late final ResidentProvider provider;

  void clearList(){
    provider.covidModel.clear();
  }

  @override
  void initState() {
    super.initState();
   // provider.covidModel = []; //todo reove when not required
    provider = Provider.of<ResidentProvider>(context, listen: false);
    for (int i = 0; i < 1; i++) {
      provider.covidModel.add(CovidSubFormModel());
    }

    if (widget.controller != null) {
      widget.controller!.getCovidFamilyData = getCovidFormData;
      widget.controller!.addCovidData = addCovidData;
      widget.controller!.clear=clearList;
    }
    provider.notifyListeners();

    if (widget.resident_opr == RESIDENT_OPR.update) getMemberData();
  }

  getMemberData() async {
    List<CovidSubFormModel>? ls =
        await provider.getMemberUsingUuid(widget.uuid, widget.resident_opr);
    setState(() {
      provider.covidModel = [];
      provider.covidModel.addAll(ls!);
    });
  }

  @override
  void dispose() {
    //  mtimer!.cancel();
    //provider.covidModel = []; //todo reove when not required
    super.dispose();
  }

  TextEditingController firstdose = new TextEditingController();
  TextEditingController seconddose = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController adhhaar = new TextEditingController();
  TextEditingController firstDoseDate = new TextEditingController();
  TextEditingController secondDoseDate = new TextEditingController();

  //TextEditingController name = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    firstdose.text = provider.covidModel[activecell].firstDostDate ?? "";
    seconddose.text = provider.covidModel[activecell].secondDoseDate ?? "";
    name.text = provider.covidModel[activecell].name ?? "";
    age.text = provider.covidModel[activecell].age ?? "";
    phoneNumber.text = provider.covidModel[activecell].mobile ?? "";
    adhhaar.text = provider.covidModel[activecell].aadhar ?? "";
    firstDoseDate.text = provider.covidModel[activecell].firstDostDate ?? "";
    secondDoseDate.text = provider.covidModel[activecell].secondDoseDate ?? "";

    provider.covidModel[activecell].memeberNo = activecell.toString();
    return Consumer<ResidentProvider>(
      builder: (context, snapshot,child) {
        return Theme(
          data: ThemeData(backgroundColor: Colors.purple),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (provider.covidModel.isNotEmpty)
                        ...provider.covidModel.mapIndexed(
                            (e, index) => _getNumberBox(index, activecell)),
                      //  _getNumberBox(2),
                      getAddMore()
                    ],
                  ),
                ),
                if (provider.covidModel.isNotEmpty)
                  ...provider.covidModel.mapIndexed((e, i) => activecell == i
                      ? Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Submit Member ${activecell + 1} Detail",
                                      style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  activecell != 0
                                      ? widget.resident_opr!=RESIDENT_OPR.update? IconButton(
                                          icon: Icon(Icons.cancel),
                                          color: Colors.red,
                                          onPressed: () async {
                                            await provider.removeMember(
                                                provider.covidModel[activecell]);
                                            setState(() {
                                              if (provider.covidModel.isNotEmpty &&
                                                  provider.covidModel.length > 1) {
                                                provider.covidModel.removeAt(activecell);
                                                //   provider.covidModel.removeAt(activecell);
                                              }

                                              setState(() {
                                                activecell = provider.covidModel
                                                    .indexOf(provider.covidModel.first);
                                              });
                                            });
                                          },
                                        ):SizedBox()
                                      : SizedBox()
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width *
                                            0.90,
                                        child: TextFormField(
                                          controller: name,
                                          onChanged: (s) {
                                            provider.covidModel[activecell].name = s;
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width *
                                            0.90,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 0, 0, 0),
                                          child: DropdownButton<String>(
                                            underline: Container(
                                              color: Colors.transparent,
                                            ),
                                            hint: Text('Select Gender'),
                                            isExpanded: true,
                                            value: provider.covidModel[activecell].gender,
                                            icon: const Icon(Icons.arrow_drop_down),
                                            iconSize: 20,
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.black),
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
                                                provider.covidModel[activecell].gender =
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width *
                                            0.90,
                                        child: TextFormField(
                                          controller: age,
                                          onChanged: (s) {
                                            provider.covidModel[activecell].age = s;
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
                            //phno
                            Container(
                              width: MediaQuery.of(context).size.width * 0.90,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.20,
                                    child: Text(
                                      "Phone Number",
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width *
                                            0.90,
                                        child: TextFormField(
                                          onChanged: (s) {
                                            provider.covidModel[activecell].mobile = s;
                                          },
                                          keyboardType: TextInputType.number,
                                          controller: phoneNumber,
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
                                              hintText:
                                                  "Type Phone number here..."),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width *
                                            0.90,
                                        child: TextFormField(
                                          controller: adhhaar,
                                          onChanged: (s) {
                                            provider.covidModel[activecell].aadhar = s;
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
                                      width:
                                          MediaQuery.of(context).size.width * 0.20,
                                      child: Text(
                                        "Vaccination Type ",
                                        style: TextStyle(fontSize: fontSize),
                                      ),
                                    ),
                                    Text(':'),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.60,
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                            ),
                                          ),
                                          width: MediaQuery.of(context).size.width *
                                              0.90,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 0, 0, 0),
                                            child: DropdownButton<String>(
                                              underline: Container(
                                                color: Colors.transparent,
                                              ),
                                              hint: Text('Select Vaccination'),
                                              isExpanded: true,
                                              value: provider.covidModel[activecell]
                                                      .vaccineType
                                                      ??
                                                  null,
                                              icon:
                                                  const Icon(Icons.arrow_drop_down),
                                              iconSize: 20,
                                              elevation: 16,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              items: this.vaccinationTypes.map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text("${value}"),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) async {
                                                setState(() {
                                                  provider.covidModel[activecell]
                                                          .vaccineType =
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width *
                                            0.90,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 0, 0, 0),
                                          child: DropdownButton<String>(
                                            underline: Container(
                                              color: Colors.transparent,
                                            ),
                                            hint: Text('Select Status'),
                                            isExpanded: true,
                                            value: provider.covidModel[activecell]
                                                .firstDoseYesNo,
                                            icon: const Icon(Icons.arrow_drop_down),
                                            iconSize: 20,
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.black),
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
                                                provider.covidModel[activecell]
                                                    .firstDoseYesNo = newValue;
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width *
                                            0.90,
                                        child: TextFormField(
                                          controller: firstdose,
                                          //initialValue:  provider.covidModel[activecell].firstDostDate,
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
                                                provider.covidModel[activecell]
                                                        .firstDostDate =
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width *
                                            0.90,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 0, 0, 0),
                                          child: DropdownButton<String>(
                                            underline: Container(
                                              color: Colors.transparent,
                                            ),
                                            hint: Text('Select Status'),
                                            isExpanded: true,
                                            value: provider.covidModel[activecell]
                                                .secondDoseYesNo,
                                            icon: const Icon(Icons.arrow_drop_down),
                                            iconSize: 20,
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.black),
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
                                                provider.covidModel[activecell]
                                                    .secondDoseYesNo = newValue;
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                        ),
                                        width: MediaQuery.of(context).size.width *
                                            0.90,
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
                                                provider.covidModel[activecell]
                                                        .secondDoseDate =
                                                    "${value.day.toString()}-${value.month.toString()}-${value.year.toString()}";
                                              });
                                            });
                                          },
                                          // initialValue: provider.covidModel[activecell].firstDostDate,
                                          onChanged: (s) {
                                            //   provider.covidModel[activecell].firstDostDate = s;
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
          ),
        );
      }
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
          provider.covidModel.add(new CovidSubFormModel());
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
              Text(
                "Add Member",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
