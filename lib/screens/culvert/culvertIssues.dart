import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/model/culvert/culvert_issue_item_zone_wise.dart';
import 'package:ghmc/provider/culvert/culvert_provider.dart';
import 'package:ghmc/util/m_progress_indicator.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/widget/container/culvert_issue_container.dart';
import 'package:ghmc/widget/dialogs/single_button_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ghmc/util/utils.dart';

class CulvertIssueScreen extends StatefulWidget {
  const CulvertIssueScreen({Key? key}) : super(key: key);

  @override
  _CulvertIssueScreenState createState() => _CulvertIssueScreenState();
}

class _CulvertIssueScreenState extends State<CulvertIssueScreen> {
  double fontSize = 14.0;
  List? status = ["Pending", "Solved"];
  var statusValue;
  CulvertIssueZoneWiseModel? model;

  @override
  void initState() {
    super.initState();
    _loadIssues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FAppBar.getCommonAppBar(title: "Culvert Issues"),
      body: model != null
          ? ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                ...model!.data!.map((e) => CulvertIssueContainer(
                      data: e,
                      onsubmit: (data) {
                        if (data.updatedStatus == null) {
                          "Please set status".showSnackbar(context);
                          return;
                        } else if (data.statusImage == null) {
                          "Please take picture before submit"
                              .showSnackbar(context);
                          return;
                        } else {
                          _submitIssue(data);
                        }
                      },
                    )),
              ],
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  Future<void> _loadIssues() async {
    final provider = Provider.of<CulvertProvider>(context, listen: false);
    ApiResponse? response = await provider.getIssuesZoneWise();
    model = CulvertIssueZoneWiseModel.fromJson(response!.completeResponse);
    setState(() {});
  }

  void _submitIssue(CulvertDataItem data) async {
    MProgressIndicator.show(context);
    final provider = Provider.of<CulvertProvider>(context, listen: false);
    ApiResponse? response = await provider.submitCulvertIssue(data);
    if (response!.status == 200) {
      SingleButtonDialog(
        message: response.message,
        onOk: (c) {
          Navigator.pop(c);
        },
        type: Imagetype.svg,
        imageurl: "assets/check.svg",
      ).pushDialog(context);
    } else {
      response.message!.showSnackbar(context);
    }
  }
}
