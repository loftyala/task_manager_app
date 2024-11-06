import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Urls{
  static const String baseUrl = "http://35.73.30.144:2005/api/v1";
  static const String registration = "$baseUrl/Registration";
  static const String login = "$baseUrl/Login";
  static const String addTask = "$baseUrl/createTask";
  static const String newTaskList= "$baseUrl//listTaskByStatus/New";
  static const String completedTaskList= "$baseUrl/listTaskByStatus/Completed";
  static const String progressTaskList= "$baseUrl/listTaskByStatus/Progress";
  static const String cancelledTaskList= "$baseUrl/listTaskByStatus/Cancelled";
  static const String taskStatusCount = '$baseUrl/taskStatusCount';
  static const String updateProfile = '$baseUrl/profileUpdate';
  static  String changeStatus(String taskId, String status) =>
      "$baseUrl/updateTaskStatus/$taskId/$status";
  static  String deleteTask(String taskId, String status) =>
      "$baseUrl/deleteTask/$taskId/$status";

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