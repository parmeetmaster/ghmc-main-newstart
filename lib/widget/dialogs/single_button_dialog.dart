import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Imagetype { png, svg }

class SingleButtonDialog extends StatefulWidget {
  final String? message;
  final Function? onOk, onCancel;
  final String? imageurl;
  final Imagetype type;
  String okbtntext;

  SingleButtonDialog({
    Key? key,
    this.message,
    this.onOk,
    this.onCancel,
    this.imageurl,
    this.type = Imagetype.svg,
    this.okbtntext = "OK",
  }) : super(key: key);

  @override
  _SingleButtonDialogState createState() => _SingleButtonDialogState();
}

class _SingleButtonDialogState extends State<SingleButtonDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 290,
          padding: EdgeInsets.only(top: 30, bottom: 30, right: 10, left: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: const Color(0xffFFFFFF)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${widget.message}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 24.0),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 30,
              ),
              if (widget.type == Imagetype.svg)
                SvgPicture.asset(
                  "${widget.imageurl}",
                  height: 50,
                ),
              if (widget.type == Imagetype.png)
                Image.asset(
                  "${widget.imageurl}",
                  height: 50,
                ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.onOk!(context);
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: const Color(0xff2cb742)),
                          child: Center(
                            child: Text("${widget.okbtntext}",
                                style: const TextStyle(
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18.0),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
