import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Urls{
  static const String baseUrl = "http://35.73.30.144:2005/api/v1";
  static const String registration = "$baseUrl/Registration";
  static const String login = "$baseUrl/Login";
  static const String addTask = "$baseUrl/createTask";
  static const String newTaskList= "$baseUrl/listTaskByStatus/New";
  static const String completedTaskList= "$baseUrl/listTaskByStatus/Completed";
  static const String progressTaskList= "$baseUrl/listTaskByStatus/Progress";
  static const String cancelledTaskList= "$baseUrl/listTaskByStatus/Cancelled";
  static const String taskStatusCount = '$baseUrl/taskStatusCount';
  static const String updateProfile = '$baseUrl/profileUpdate';
  static const String recoverVerifyEmail = "$baseUrl/RecoverVerifyEmail";
  static  String changeStatus(String taskId, String status) =>
      "$baseUrl/updateTaskStatus/$taskId/$status";
  static  String deleteTask(String taskId) =>
      "$baseUrl/deleteTask/$taskId";

  static String recoveryVarifiedEmail (String email) {
    return '$baseUrl/RecoverVerifyEmail/$email';
  }

  static String recoverVerifyOtp (String email, String otp) {
    return '$baseUrl/RecoverVerifyOtp/$email/$otp';
  }

  static const String recoverResetPassword = '$baseUrl/RecoverResetPassword';


}




void showSnackBarMessage(BuildContext context, String? message, bool isError) {
  if (message != null && context != null) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}