// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:ghmc/api/api.dart';
// import 'package:ghmc/model/culvert/area_model.dart';
// import 'package:ghmc/model/culvert/culvert_issue.dart';
// import 'package:ghmc/model/culvert/culvert_issue_name.dart';
// import 'package:ghmc/provider/culvert/culvert_provider.dart';
// import 'package:ghmc/screens/dashboard/dashBordScreen.dart';
// import 'package:ghmc/util/file_picker.dart';
// import 'package:ghmc/widget/appbar/appbar.dart';
// import 'package:ghmc/widget/dialogs/single_button_dialog.dart';
// import 'package:provider/provider.dart';
// import 'package:ghmc/util/utils.dart';
//
// class CulvertScreen extends StatefulWidget {
//   CulvertIssue culvertIssue;
//
//   CulvertScreen(this.culvertIssue, {Key? key}) : super(key: key);
//
//   @override
//   _CulvertScreenState createState() => _CulvertScreenState();
// }
//
// class _CulvertScreenState extends State<CulvertScreen> {
//   List<String> issueType = ['green', 'orange', 'red'];
//
//   String? issueTypeValue;
//
//   double fontSize = 14.0;
//
//   File? photo;
//   CulvertIssueName? culvertIssue;
//   CulvertIssueNameItem? culvertIssueName;
//
//   @override
//   void initState() {
//     super.initState();
//     _getIssueName();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: FAppBar.getCommonAppBar(title: "Culvert"),
//       body: culvertIssue!=null?SingleChildScrollView(
//         child: Column(
//           children: [
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.90,
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.30,
//                             child: Text(
//                               "Culvert Type",
//                               style: TextStyle(fontSize: fontSize),
//                             ),
//                           ),
//                           Text(':'),
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.58,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 '${widget.culvertIssue.data!.culvertType ?? ""}',
//                                 style: TextStyle(fontSize: fontSize),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.30,
//                             child: Text(
//                               "Culvert Name",
//                               style: TextStyle(fontSize: fontSize),
//                             ),
//                           ),
//                           Text(':'),
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.58,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 '${widget.culvertIssue.data!.culvertName ?? ""}',
//                                 style: TextStyle(fontSize: fontSize),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.30,
//                             child: Text(
//                               "Landmark",
//                               style: TextStyle(fontSize: fontSize),
//                             ),
//                           ),
//                           Text(':'),
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.58,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 '${widget.culvertIssue.data!.landmark ?? ""}',
//                                 style: TextStyle(fontSize: fontSize),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.30,
//                             child: Text(
//                               "Area/Colony",
//                               style: TextStyle(fontSize: fontSize),
//                             ),
//                           ),
//                           Text(':'),
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.58,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 '${widget.culvertIssue.data!.area ?? ""}',
//                                 style: TextStyle(fontSize: fontSize),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.30,
//                             child: Text(
//                               "Ward",
//                               style: TextStyle(fontSize: fontSize),
//                             ),
//                           ),
//                           Text(':'),
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.58,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 '${widget.culvertIssue.data!.ward ?? ""}',
//                                 style: TextStyle(fontSize: fontSize),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.30,
//                             child: Text(
//                               "Circle",
//                               style: TextStyle(fontSize: fontSize),
//                             ),
//                           ),
//                           Text(':'),
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.58,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 '${widget.culvertIssue.data!.circle ?? ""}',
//                                 style: TextStyle(fontSize: fontSize),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             child: Text(
//                               "Zone",
//                               style: TextStyle(fontSize: fontSize),
//                             ),
//                             width: MediaQuery.of(context).size.width * 0.30,
//                           ),
//                           Text(':'),
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.58,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 '${widget.culvertIssue.data!.zone ?? ""}',
//                                 style: TextStyle(fontSize: fontSize),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             this.photo == null
//                 ? Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 250,
//                       width: 340,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.black12,
//                           ),
//                           borderRadius: BorderRadius.circular(15.0)),
//                       child: Center(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             FloatingActionButton(
//                                 backgroundColor: Colors.black,
//                                 onPressed: () async {
//                                   photo = await FilePick().takecameraPic();
//                                   setState(() {});
//                                 },
//                                 child: Icon(
//                                   Icons.camera_alt_outlined,
//                                   color: Colors.white,
//                                   size: 40,
//                                 )),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 250,
//                       width: 340,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.black12,
//                           ),
//                           borderRadius: BorderRadius.circular(15.0)),
//                       child: Center(
//                         child: Padding(
//                             padding: EdgeInsets.symmetric(vertical: 10),
//                             child: Image.file(this.photo!)),
//                       ),
//                     ),
//                   ),
//           SizedBox(height: 10,),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.90,
//               decoration: ShapeDecoration(
//                 shape: RoundedRectangleBorder(
//                   side: BorderSide(
//                     width: 1.0,
//                     style: BorderStyle.solid,
//                     color: Colors.grey,
//                   ),
//                   borderRadius: BorderRadius.all(
//                       Radius.circular(5.0)),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(
//                     8.0, 0, 0, 0),
//                 child: DropdownButton<CulvertIssueNameItem>(
//                   underline: Container(
//                     color: Colors.transparent,
//                   ),
//                   hint: Text('Issue Name'),
//                   isExpanded: true,
//                   value: culvertIssueName,
//                   icon:
//                   const Icon(Icons.arrow_drop_down),
//                   iconSize: 20,
//                   elevation: 16,
//                   style: const TextStyle(
//                       color: Colors.black),
//                   items: culvertIssue!.data!
//                       .map<DropdownMenuItem<CulvertIssueNameItem>>(
//                           (CulvertIssueNameItem value) {
//                             if(value.status!.toLowerCase()=="active")
//                         return DropdownMenuItem<CulvertIssueNameItem>(
//                           value: value,
//                           child: Text("${value.name}"),
//                         );
//                             else
//                             return DropdownMenuItem<CulvertIssueNameItem>(
//                                 value: value,
//                                 child: Container(),
//                                    );
//                       }).toList(),
//                   onChanged: (newValue) async {
//                     setState(() {
//                       culvertIssueName =newValue as CulvertIssueNameItem;
//                     });
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 10,),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 decoration: ShapeDecoration(
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(
//                       width: 1.0,
//                       style: BorderStyle.solid,
//                       color: Colors.grey,
//                     ),
//                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                   ),
//                 ),
//                 width: MediaQuery.of(context).size.width * 0.90,
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
//                   child: DropdownButton(
//                     underline: Container(
//                       color: Colors.transparent,
//                     ),
//                     hint: Text('Issue Type'),
//                     isExpanded: true,
//                     value: issueTypeValue,
//                     icon: const Icon(Icons.arrow_drop_down),
//                     iconSize: 20,
//                     elevation: 16,
//                     style: const TextStyle(color: Colors.black),
//                     items:
//                         issueType.map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(
//                         () {
//                           issueTypeValue = newValue!;
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.80,
//               child: TextButton(
//                   onPressed: () async {
//                     if (photo == null) {
//                       "Please add photograph".showSnackbar(context);
//                       return;
//                     }
//                     if (issueTypeValue == null) {
//                       "Please add Issue Type".showSnackbar(context);
//                       return;
//                     }
//
//                     final provider =
//                         Provider.of<CulvertProvider>(context, listen: false);
//                     ApiResponse resp = await provider.submit(
//
//                         widget.culvertIssue, photo, issueTypeValue,culvertIssueName);
//
//                     if (resp.status == 200) {
//                       SingleButtonDialog(
//                         okbtntext: "Done",
//                         onOk: (c) {
//                           DashBoardScreen().pushAndPopTillFirst(context);
//                         },
//                         imageurl: "assets/check.svg",
//                         type: Imagetype.svg,
//                         message: resp.message,
//                         onCancel: (c) {
//                           Navigator.of(c).pop();
//                           DashBoardScreen().pushAndPopTillFirst(context);
//                         },
//                       ).pushDialog(context);
//                     }
//
//                     if (resp.status != 200) {
//                       resp.message!.showSnackbar(context);
//                     }
//                   },
//                   child: Text(
//                     'Submit',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   )),
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Color(0xFFAD1457), Color(0xFFAD801D9E)],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                   borderRadius: BorderRadius.circular(30.0)),
//             ),
//           ],
//         ),
//       ):Container(child: Center(child: CircularProgressIndicator(),),),
//     );
//   }
//
//   Future<void> _getIssueName() async {
//     final provider = Provider.of<CulvertProvider>(context, listen: false);
//     ApiResponse? response = await provider.getCulvertIssuesTypes();
//     culvertIssue = CulvertIssueName.fromJson(response!.completeResponse);
//     setState(() {
//
//     });
//   }
// }
