import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:ghmc/util/m_progress_indicator.dart';

List<CameraDescription?>? cameras;

class CameraPicture extends StatefulWidget {
  @override
  _CameraPictureState createState() => _CameraPictureState();
}

class _CameraPictureState extends State<CameraPicture> {
  CameraController? controller;

  loadCamera() async {
    Future.delayed(Duration(seconds: 1)).then((value) async {
      cameras = await availableCameras();
      controller = CameraController(
        cameras![0]!,
        ResolutionPreset.max,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadCamera();
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Stack(
          children: [
            CameraPreview(
              controller!,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 30.0,
                ),
                child: GestureDetector(
                    onTap: () async {
                      try {
                        await controller!.initialize();
                        MProgressIndicator.show(context);
                        XFile file = await controller!.takePicture();
                        MProgressIndicator.hide();
                        Navigator.pop(context, File(file.path));
                      } catch (e) {}
                    },
                    child: Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: 70,
                    )),
              ),
            ),
          ],
        ),
      );
    }
  }
}
