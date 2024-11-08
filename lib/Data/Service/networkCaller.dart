import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_app/main.dart';

import '../../OnBoardingScreens/login.dart';
import '../../sharedPreference/auth_controller.dart';
import '../Model/network_response.dart';
import '../utils.dart';


class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'token': AuthController.accessToken ?? '', // Use empty string if null
      };
      printRequest(url, null, headers);
      final Response response = await get(uri, headers: headers);
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        await _moveToLogIn(); // Updated method call
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthenticated!',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': AuthController.accessToken ?? '', // Use empty string if null
      };
      printRequest(url, body, headers);
      final Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);

        if (decodeData['status'] == 'fail') {
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodeData['data'],
          );
        }

        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        await _moveToLogIn(); // Updated method call
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthenticated!',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  /// New method to initiate email verification
  static Future<NetworkResponse> initiateEmailVerification(String email) async {
    final url = '${Urls.recoverVerifyEmail}/$email';
    return await getRequest(url: url);
  }

  /// New method to verify the email code (if required by your API)
  static Future<NetworkResponse> verifyEmailCode({
    required String email,
    required String code,
  }) async {
    final url = '${Urls.baseUrl}/VerifyEmailCode'; // Adjust this URL as needed
    final body = {
      "email": email,
      "code": code,
    };
    return await postRequest(url: url, body: body);
  }

  static void printRequest(
      String url, Map<String, dynamic>? body, Map<String, String>? headers) {
    debugPrint(
      'REQUEST:\nURL: $url\nBODY: $body\nHEADERS: $headers',
    );
  }

  static void printResponse(String url, Response response) {
    debugPrint(
      'URL: $url\nRESPONSE CODE: ${response.statusCode}\nBODY: ${response.body}',
    );
  }

  static Future<void> _moveToLogIn() async { // Updated method name
    await AuthController.clearAccessToken(); // Clear the access token
    Navigator.pushAndRemoveUntil(
      MyApp.navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Updated to LogInScreen
          (route) => false,
    );
  }
}
