import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:ghmc/util/utils.dart';

class GridImage extends StatefulWidget {
  final BuildContext context;
  final Function(List<File> files) onchange;

  final String? title;

  GridImage(
      {Key? key, required this.context, required this.onchange, this.title})
      : super(key: key);

  @override
  _GridImageState createState() => _GridImageState();
}

class _GridImageState extends State<GridImage> {
  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    final imageGrabber = GestureDetector(
      onTap: () {
        pickImage(widget.context);
      },
      child: Container(
        width: 200,
        height: 200,
        //color: Colors.red,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/images/add_image.png",
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );

    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.title != null
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.title}",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ))
            : const SizedBox(),
        GridView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          children: [
            ...images.mapIndexed(
              (file, i) => _getImageContiner(i, file),
            ),
            imageGrabber
          ],
        ),
      ],
    ));
  }

  _getImageContiner(index, File file) {
    return Container(
      width: 200,
      height: 200,
      //color: Colors.red,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(
                        file,
                      )),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              )),
          Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      images.removeAt(index);
                      widget.onchange(images);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0, right: 4),
                    child: Image.asset(
                      "assets/images/remove.png",
                      height: 20,
                    ),
                  )))
        ],
      ),
    );
  }

  void pickImage(
    context,
  ) async {
    PickedFile? res;
    Dialogs.bottomMaterialDialog(
        title: 'Choose Camera or gallery',
        context: context,
        actions: [
          IconsButton(
            onPressed: () async {
              Navigator.pop(context);
              res = (await ImagePicker.platform
                  .pickImage(source: ImageSource.camera))!;
              updateImages(res);
            },
            text: 'Camera',
            iconData: Icons.camera_alt,
            color: Colors.green,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () async {
              Navigator.pop(context);
              res = (await ImagePicker.platform
                  .pickImage(source: ImageSource.gallery))!;
              updateImages(res);
            },
            text: 'Gallery',
            iconData: Icons.camera,
            color: Colors.red,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  void updateImages(PickedFile? res) {
    if (res == null) {
      "Response is null".printinfo;
    } else {
      res.path.printwtf;
      setState(() {
        images.add(File(res.path));
        widget.onchange(images);
      });
    }
  }
}
