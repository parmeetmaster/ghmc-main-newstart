import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/provider/dashboard_provider/dash_board_provider.dart';
import 'package:ghmc/provider/login_provider/login_provider.dart';
import 'package:ghmc/screens/dashboard/dashBordScreen.dart';
import 'package:ghmc/widget/appbar/appbar.dart';
import 'package:ghmc/widget/buttons/gradeint_button.dart';
import 'package:ghmc/util/utils.dart';
import 'package:ghmc/widget/dialogs/single_button_dialog.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

/* validations
* all fields not empty
* alpha numerics allowed
* api not respond handling -- pending
* new password must match
*
*
* */

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController old_password = new TextEditingController();
  TextEditingController new_password = new TextEditingController();
  TextEditingController new_confirm_password = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: main_color,
      //       ),
      //     ),
      //   ),
      //   title: Text('Change Password'),
      // ),
      appBar: FAppBar.getCommonAppBar(title: "Change Password"),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Image.asset(
                "assets/images/padlock.png",
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 40,
              ),
              _get_password_widget(old_password, "Old Password",
                  prefix: Icon(Icons.vpn_key_outlined)),
              SizedBox(
                height: 20,
              ),
              _get_password_widget(new_password, "New Password",
                  prefix: Icon(Icons.vpn_key)),
              SizedBox(
                height: 20,
              ),
              _get_password_widget(new_confirm_password, "Confirm New Password",
                  prefix: Icon(Icons.vpn_key)),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: GradientButton(
                  title: "Reset Password",
                  onclick: submit,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _get_password_widget(TextEditingController controller, String label,
      {Widget? prefix}) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: prefix,
            enabledBorder: const OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            focusColor: Colors.black45,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 2.0),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            border: OutlineInputBorder(),
            labelText: label,
            labelStyle: TextStyle(color: Colors.black)),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field should not be empty';
          }
          return null;
        },
      ),
    );
  }

  submit() {
    final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
    // no empty
    if (old_password.text.isEmpty) {
      "Please add old password".showSnackbar(context);
      return;
    }
    // no empty
    if (new_password.text.isEmpty) {
      "New Password Can'nt be Empty".showSnackbar(context);
      return;
    }
    // no empty
    if (new_confirm_password.text.isEmpty) {
      "Confirm Can'nt be Empty".showSnackbar(context);
      return;
    }
// check only alpha numeric allowed
    if (!validCharacters.hasMatch(new_password.text)) {
      "Only AlphaNumeric Characters are allowed in Password"
          .showSnackbar(context);
      return;
    }
// check only alpha numeric allowed
    if (!validCharacters.hasMatch(new_confirm_password.text)) {
      "Only AlphaNumeric Characters are allowed in Password"
          .showSnackbar(context);
      return;
    }
    // check length should 8
    if (new_password.text.characters.length < 9 ||
        new_confirm_password.text.characters.length < 9) {
      "New Password length must greater than 8".showSnackbar(context);
      return;
    }

    // check both password match
    if (new_password.text != new_confirm_password.text) {
      "New password and confirm password not matched".showSnackbar(context);
      return;
    }

    // call update passwords
    peform_update_password(
        old_password: old_password,
        new_password: new_password,
        new_confirm_password: new_confirm_password);
  }

  void peform_update_password(
      {TextEditingController? old_password,
      TextEditingController? new_password,
      TextEditingController? new_confirm_password}) async {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    ApiResponse response = await provider.update_password(
        old_password: old_password,
        new_password: new_password,
        new_confirm_password: new_confirm_password);

    if (response.status == 200) {
      SingleButtonDialog(
        imageurl: "assets/check.svg",
        type: Imagetype.svg,
        message: response.message,
        onOk: (c) {
          DashBoardScreen().pushAndPopTillFirst(context);
        },
      ).pushDialog(context);
    } else {
      response.message!.showSnackbar(context);
    }
  }
}
