import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/model/culvert/culvert_issue_item_zone_wise.dart';
import 'package:ghmc/widget/container/camera_gallery_container.dart';
import 'package:intl/intl.dart';

import 'camera_container_culvert_issue.dart';

class CulvertIssueContainer extends StatefulWidget {
  CulvertDataItem data;
  Function(CulvertDataItem) onsubmit;

  CulvertIssueContainer({required this.data, required this.onsubmit});

  @override
  _CulvertIssueContainerState createState() => _CulvertIssueContainerState();
}

class _CulvertIssueContainerState extends State<CulvertIssueContainer> {
  double fontSize = 14.0;
  List? status = ["Pending", "Solved"];
  var statusValue;
  CulvertIssueZoneWiseModel? model;

  @override
  Widget build(BuildContext context) {
/*    DateTime parseDate =
    new DateFormat("yyyy-MM-dd").parse(wid);*/
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey)),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: (() {
                      if (widget.data.type!.toLowerCase() == "green") {
                        return Colors.green[400];
                      } else if (widget.data.type!.toLowerCase() == "orange") {
                        return Colors.orange[800];
                      } else {
                        return Colors.red[400];
                      }
                    }())),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      ":",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      "${widget.data.date}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
              _rowWidget(
                context,
                'Culvert Name',
                "${widget.data.issueName}",
              ),
              _rowWidget(
                context,
                'Depth',
                "${widget.data.depth}",
              ),
              _rowWidget(
                context,
                'Issue Depth',
                "${widget.data.issueDepth}",
              ),
              _rowWidget(
                context,
                'Culvert Type',
                "${widget.data.type}",
              ),
              _rowWidget(
                context,
                'Area/Colony',
                "${widget.data.area}",
              ),
              _rowWidget(
                context,
                'Ward',
                "${widget.data.ward}",
              ),
              _rowWidget(
                context,
                'Landmark',
                "${widget.data.landmark}",
              ),
              _rowWidget(
                context,
                'Circle',
                "${widget.data.circle}",
              ),
              _rowWidget(
                context,
                'Zone',
                "${widget.data.zone}",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: Text(
                        "Issue culvert",
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Text(':'),
                  Container(
                    padding: EdgeInsets.only(right: 90),
                    width: MediaQuery.of(context).size.width * 0.58,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: CachedNetworkImage(
                      imageUrl: "${widget.data.image}",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.red, BlendMode.colorBurn)),
                        ),
                      ),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        "Status",
                        style: TextStyle(fontSize: fontSize),
                      ),
                      width: MediaQuery.of(context).size.width * 0.30,
                    ),
                  ),
                  Text(':'),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.57,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 8, top: 8, bottom: 8),
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
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                          child: DropdownButton(
                            underline: Container(
                              color: Colors.transparent,
                            ),
                            hint: Text('Status'),
                            isExpanded: true,
                            value: statusValue,
                            items: status!.map((e) {
                              return DropdownMenuItem(
                                  value: e, child: Text("$e"));
                            }).toList(),
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 20,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (newValue) {
                              setState(() {
                                statusValue = newValue!;
                                widget.data.updatedStatus = newValue as String;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                    child: Container(
                      child: Text(
                        "Status Image",
                        style: TextStyle(fontSize: fontSize),
                      ),
                      width: MediaQuery.of(context).size.width * 0.30,
                    ),
                  ),
                  Text(':'),
                  Container(
                    padding: EdgeInsets.only(right: 8),
                    width: MediaQuery.of(context).size.width * 0.56,
                    height: MediaQuery.of(context).size.height * 0.15,
                    // child: CameraContainerCulvertIssue(oncapture: (file ) {
                    //   widget.data.statusImage=file;
                    // },),
                    child: CameraGalleryContainerWidget(
                      oncapture: (file) {
                        widget.data.statusImage = file;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.50,
                child: TextButton(
                    onPressed: () {
                      widget.onsubmit(widget.data);
                    },
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
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rowWidget(BuildContext context, String? key, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.30,
            child: Text(
              key!,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ),
        Text(':'),
        Container(
          width: MediaQuery.of(context).size.width * 0.58,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value!,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ),
      ],
    );
  }
}
