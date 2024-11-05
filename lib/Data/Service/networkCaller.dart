import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_app/Data/Model/network_response.dart';
import 'package:task_manager_app/sharedPreference/auth_controller.dart';
import '../../OnBoardingScreens/login.dart';

class NetworkCaller {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      final Response response = await get(uri, headers: _getHeaders()).timeout(Duration(seconds: 10));
      printResponse(url, response);

      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        if (decodeData['status'] == 'fail') {
          return NetworkResponse(isSuccess: false, statusCode: response.statusCode, responseData: decodeData['data']);
        }
        return NetworkResponse(isSuccess: true, statusCode: response.statusCode, responseData: decodeData);
      } else if (response.statusCode == 401) {
        await moveToLogin();
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode, errorMessage: 'Unauthorized');
      } else {
        final errorData = jsonDecode(response.body);
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode, errorMessage: errorData['message'] ?? 'An error occurred');
      }
    } on TimeoutException catch (_) {
      return NetworkResponse(isSuccess: false, statusCode: 408, errorMessage: 'Request Timeout');
    } on SocketException catch (_) {
      return NetworkResponse(isSuccess: false, statusCode: 503, errorMessage: 'No Internet connection');
    } catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: 500, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(String url, {Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      printRequest(url, body, _getHeaders());

      final Response response = await post(uri, headers: _getHeaders(), body: jsonEncode(body)).timeout(Duration(seconds: 10));
      printResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(isSuccess: true, statusCode: response.statusCode, responseData: decodeData);
      } else if (response.statusCode == 401) {
        await moveToLogin();
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode, errorMessage: 'Unauthorized');
      } else {
        final errorData = jsonDecode(response.body);
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode, errorMessage: errorData['message'] ?? 'An error occurred');
      }
    } on TimeoutException catch (_) {
      return NetworkResponse(isSuccess: false, statusCode: 408, errorMessage: 'Request Timeout');
    } on SocketException catch (_) {
      return NetworkResponse(isSuccess: false, statusCode: 503, errorMessage: 'No Internet connection');
    } catch (e) {
      return NetworkResponse(isSuccess: false, statusCode: 500, errorMessage: e.toString());
    }
  }

  static Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'token': AuthController.getAccessToken.toString(),
    };
  }

  static void printRequest(String url, Map<String, dynamic>? body, Map<String, dynamic>? headers) {
    debugPrint('[$_timestamp] REQUEST:\nURL: $url\nBODY: $body\nHEADERS: $headers');
  }

  static void printResponse(String url, Response response) {
    debugPrint('[$_timestamp] RESPONSE:\nURL: $url\nRESPONSE CODE: ${response.statusCode}\nBODY: ${response.body}');
  }

  static Future<void> moveToLogin() async {
    await AuthController.clearAccessToken();
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
    );
  }

  static String get _timestamp => DateTime.now().toIso8601String();
}
