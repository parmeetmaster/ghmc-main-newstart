import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ghmc/util/file_picker.dart';
import 'package:ghmc/util/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera_camera/camera_camera.dart';

class CameraGalleryContainerWidget extends StatefulWidget {
  Function(File)? oncapture;

  CameraGalleryContainerWidget({Key? key, required this.oncapture})
      : super(key: key);

  @override
  _CameraGalleryContainerWidgetState createState() =>
      _CameraGalleryContainerWidgetState();
}

class _CameraGalleryContainerWidgetState
    extends State<CameraGalleryContainerWidget> {
  File? photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this.photo == null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.33,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(24),
                        primary: Colors.black),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                    ),
                    onPressed: () async {
                      // photo = await FilePick().takecameraPic();
                      // if (photo != null) {
                      //   "Photo taken".printinfo;
                      //   if (widget.oncapture != null) {
                      //     widget.oncapture!(photo!);
                      //   }
                      // }
                      // setState(() {});
                      /// new code
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraCamera(
                            resolutionPreset: ResolutionPreset.low,
                            onFile: (file) async {
                              "Photo taken".printinfo;
                              setState(() {
                                photo = File(file.path);
                              });
                              if (widget.oncapture != null) {
                                widget.oncapture!(photo!);
                              }
                              Navigator.pop(context);
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.33,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Image.file(this.photo!)),
                ),
              ),
            ),
    );
  }
}
