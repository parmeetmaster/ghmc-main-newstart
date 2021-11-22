import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/globals/globals.dart';
import 'package:ghmc/provider/login_provider/login_provider.dart';
import 'package:ghmc/util/utils.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // types
  bool errorLogin = false;

  // formKey for form validation
  final _formKey = GlobalKey<FormState>();

  // TextEditingController
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginProvider? _instance;
  bool obsecure = true;

  @override
  Widget build(BuildContext context) {

    if(Globals.checkAppOnTest()){
      _emailController.text="9347280791";
     _passwordController.text="9347280791";
    }



    _instance = LoginProvider.getInstance(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFFAD1457),
                    Color(0xFFAD801D9E),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 50.0),
                Center(
                  child: Image.asset(
                    "assets/images/main_logo.png",
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: MediaQuery.of(context).size.width * 0.70,
                  ),
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.60,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _sizedBox(context),
                        Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        _sizedBox(context),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFAD801D9E), width: 2.0),
                                  borderRadius: BorderRadius.circular(29)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(29),
                                borderSide: BorderSide(
                                    color: Color(0xFFAD801D9E), width: 2.0),
                              ),
                              hintText: 'USER NAME',
                              prefixIcon: Container(
                                margin: EdgeInsets.only(left: 8, right: 8),
                                width: MediaQuery.of(context).size.width * 0.10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xFFAD1457),
                                      Color(0xFFAD801D9E),
                                    ],
                                  ),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: obsecure,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFAD801D9E), width: 2.0),
                                borderRadius: BorderRadius.circular(29),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(29),
                                borderSide: BorderSide(
                                    color: Color(0xFFAD801D9E), width: 2.0),
                              ),
                              hintText: 'PASSWORD',
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    this.obsecure = !this.obsecure;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.remove_red_eye),
                                ),
                              ),
                              prefixIcon: Container(
                                width: MediaQuery.of(context).size.width * 0.10,
                                margin: EdgeInsets.only(left: 8, right: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xFFAD1457),
                                      Color(0xFFAD801D9E),
                                    ],
                                  ),
                                ),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        _sizedBox(context),
                        InkWell(
                          onTap: () async {
                            if (_emailController.text.isEmpty &&
                                _passwordController.text.isEmpty) {
                              "Email and password Both required"
                                  .showSnackbar(context);
                              return;
                            }

                            await _instance!.performLogin(
                                _emailController, _passwordController, context);
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                "SIGN IN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(colors: main_color),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sizedBox(BuildContext context) {
    return SizedBox(height: 20.0);
  }

}
