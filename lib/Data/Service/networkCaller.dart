import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_app/Data/Model/network_response.dart';

class NetworkCaller {
 static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(uri.toString());
      final Response response = await get(uri);
      printResponse(url, response); // Pass the correct type
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      } else {
        // Handle non-200 responses if needed
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      // Handle exceptions
      return NetworkResponse(
        isSuccess: false,
        statusCode: 500,
        errorMessage: e.toString(),
      ); // Example error code
    }
  }
 static Future<NetworkResponse> postRequest(String url, Map<String, dynamic>? body) async {
  try {
    Uri uri = Uri.parse(url);
    debugPrint(uri.toString());

    // Use post method instead of get
    final Response response = await post(
      uri,
      headers: {"Content-Type": "application/json"}, // Set content type if needed
      body: jsonEncode(body), // Encode the body to JSON
    );

    printResponse(url, response); // Pass the correct type
    if (response.statusCode == 200 || response.statusCode == 201) { // Handle success codes
      final decodeData = jsonDecode(response.body);
      return NetworkResponse(
        isSuccess: true,
        statusCode: response.statusCode,
        responseData: decodeData,
      );
    } else {
      // Handle non-200 responses if needed
      return NetworkResponse(isSuccess: false, statusCode: response.statusCode);
    }
  } catch (e) {
    // Handle exceptions
    return NetworkResponse(
      isSuccess: false,
      statusCode: 500,
      errorMessage: e.toString(),
    ); // Example error code
  }
}

  static void printResponse(String url, Response response) { // Change parameter type to Response
    debugPrint("URL: $url\n Response: ${response.statusCode} \n ${response.body}");
  }
}
