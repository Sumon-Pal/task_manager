import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/ui/screens/controlers/auth_controler.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? body;
  final String? errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.errorMessage,
  });
}

class NetworkCaller {
  static const String _defaultErrorMessage = 'Something went wrong';
  static const String _unAuthorizedMessage = 'Un-authorized Token';

  static Future<NetworkResponse> getRequest({required String url}) async {
    print("==========================\n");
    print(AuthController.accessToken);
    print("==========================\n");
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url, null,null);

      Response response = await get(uri);

      _logResponse(url, response, );

      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            body: decodeJson,
        );
      }else if(response.statusCode == 401){
        _onUnAuthorized();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage:_unAuthorizedMessage,
        );
      }else{
        final decodeJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          body: decodeJson,
          errorMessage: decodeJson['data']??_defaultErrorMessage
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString()
      );
    }
  }


  static Future<NetworkResponse> postRequest({required String url, Map<String, String>? body, bool isFromLogin = false}) async {
    print("==========================\n");
    print(AuthController.accessToken);
    print("==========================\n");
    final Map<String, String> headers ={
      'content-Type':'application/json',
      'token': AuthController.accessToken ?? '',
    };
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url, null,headers);

      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      _logResponse(url, response);

      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            body: decodeJson,
        );
      }else if(response.statusCode == 401){
        if(isFromLogin) {
          _onUnAuthorized();
        }
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage:_unAuthorizedMessage,
        );
      }else{
        final decodeJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          body: decodeJson,
          errorMessage: decodeJson['data']??_defaultErrorMessage
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString()
      );
    }
  }

  static Future<void> _onUnAuthorized()async{
    await AuthController.clearData();
    Navigator.of(TaskManager.navigator.currentContext!).pushNamedAndRemoveUntil(SignInScreen.name, (predicate)=>false);
  }

  static void _logRequest(String url, Map<String, String>? body,Map<String, String>? headers){
    debugPrint("==================== REQUEST ======================'\n'"
        "URL:$url\n"
        "HEADERS:$headers\n"
        "BODY:$body\n"
        "============================================="
    );
  }
  static void _logResponse(String url, Response response){
    debugPrint("==================== RESPONSE ======================'\n'"
        "URL:$url\n"
        "STATUS CODE: ${response.statusCode}\n"
        "BODY:${response.body}\n"
        "============================================="
    );
  }

}