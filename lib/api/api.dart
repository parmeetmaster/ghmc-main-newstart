import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ghmc/globals/globals.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

///const String base_url = "http://ghmc.iotroncs.com";
const String base_url ="http://13.233.159.132:2000";

abstract class Status {
// [Description("true")]
  static const Success = 200,

// [Description("false")]
      Failed = 400,
      Dead = 0,
      EmptyModel = 202,
      Unauthorized = 401,
      Duplicate = 409,
      VerifyEmail = 5001;
}

class ApiBase {
  static Dio? dio;

  Dio? getInstance() {
    if (dio == null) {
      _initialize();
    }

    if (Globals.userData != null) {
      print("TOKEN IS : ${Globals.userData!.data!.token!}");
      dio!.options.headers.addAll(
          {"Authorization": "Bearer " + Globals.userData!.data!.token!});
    }

    return dio;
  }

  _initialize() {
    dio = new Dio(BaseOptions(
        baseUrl: base_url,
        receiveTimeout: 30000,
        connectTimeout: 30000,
        contentType: "application/x-www-form-urlencoded"))
      ..interceptors.add(PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        //   responseHeader : true,
        responseBody: true,
        error: true,

        compact: true,
      ));
  }

  Future<ApiResponse> baseFunction(ResponseCallback callback) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Response resp = await callback();
        return ApiResponse(
            completeResponse: resp.data,
            status: 200,
            result: resp.data['result'],
            message: resp.data['message'] ?? "No Message");
      } else
        return ApiResponse(
            message: "Something went wrong", status: Status.Failed, result: {});
    } on SocketException {
      return ApiResponse(
          message: "Check your internet connection",
          status: Status.Dead,
          result: {});
    } on DioError catch (error) {
      print("in dio error");
      print(error);
      print(error.response?.data);
      return ApiResponse(
          message: (error.response?.data ?? {})['message']?.toString() ??
              error.message,
          result: (error.response?.data ?? {})['result'] ?? {},
          status: error.response?.statusCode ?? Status.Failed,
          completeResponse: error.response?.data);
    } catch (error) {
      print(error);
      // rethrow;

      return ApiResponse(
        message: "Something went wrong",
        status: Status.Failed,
        result: {},
      );
    }
  }
}

typedef Future<Response> ResponseCallback();

class ApiResponse<T> {
  int? status;
  String? message;
  T? result;
  T? completeResponse;

  ApiResponse({this.status, this.message, this.result, this.completeResponse});
}
