import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DialogPoPUp extends StatefulWidget {
  final String? message;
  final Function? onOk, onCancel;
  final String? imageurl;
  String okbtntext, cancelbtntext;

  DialogPoPUp(
      {Key? key,
      this.message,
      this.onOk,
      this.onCancel,
      this.imageurl,
      this.okbtntext = "OK",
      this.cancelbtntext = "Cancel"})
      : super(key: key);

  @override
  _DialogPoPUpState createState() => _DialogPoPUpState();
}

class _DialogPoPUpState extends State<DialogPoPUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 275,
          padding: EdgeInsets.only(top: 30, bottom: 30, right: 10, left: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: const Color(0xff4d159e)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${widget.message}",
                  style: const TextStyle(
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 24.0),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 30,
              ),
              SvgPicture.asset(
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
                      child: Container(
                        width: 155,
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                    GestureDetector(
                      onTap: () {
                        widget.onCancel!(context);
                      },
                      child: Container(
                        width: 155,
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: const Color(0xffef3939)),
                        child: Center(
                          child: Text("${widget.cancelbtntext}",
                              style: const TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18.0),
                              textAlign: TextAlign.center),
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
