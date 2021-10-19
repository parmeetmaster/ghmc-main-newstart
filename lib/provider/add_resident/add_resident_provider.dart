

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc/api/api.dart';
import 'package:ghmc/util/extension.dart';

class AddResidentProvider extends ChangeNotifier{

  performAddResident( FormData formData,BuildContext context)async{
    ApiResponse response = await ApiBase().baseFunction(() => ApiBase()
        .getInstance()!
        .post("/createresidential_house", data: formData));
    if (response.status == 200) {
      response.message!.showSnackbar(context);
      return response;
    } else {
      response.message!.showSnackbar(context);
      return response;
    }


  }


}