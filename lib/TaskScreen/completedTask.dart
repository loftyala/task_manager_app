import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:task_manager_app/Data/Model/TaskModel.dart';
import 'package:task_manager_app/widget/taskCard.dart';

import '../Data/Model/network_response.dart';
import '../Data/Model/taskLIstModel.dart';
import '../Data/Service/networkCaller.dart';
import '../Data/utils.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  var _getCompletedTaskListInProgress = false.obs; // Observable for loading state
  var _completedTaskList = <TaskModel>[].obs; // Observable list for tasks

  @override
  void initState() {
    _getCompletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
      visible: !_getCompletedTaskListInProgress.value,
      replacement: Center(child: CircularProgressIndicator()),
      child: RefreshIndicator(
        onRefresh: _getCompletedTaskList,
        child: ListView.builder(
          itemCount: _completedTaskList.length,
          itemBuilder: (context, index) {
            return taskCard(
              onRefreshList: _getCompletedTaskList,
              key: UniqueKey(),
              taskModel: _completedTaskList[index], // Passing a TaskModel instance
            );
          },
        ),
      ),
    ));
  }

  Future<void> _getCompletedTaskList() async {
    _completedTaskList.clear();
    _getCompletedTaskListInProgress.value = true;

    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.completedTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _completedTaskList.assignAll(taskListModel.taskList ?? []);
    } else {
      Get.snackbar('Error', response.errorMessage, snackPosition: SnackPosition.BOTTOM, colorText: Colors.white, backgroundColor: Colors.red);
    }
    _getCompletedTaskListInProgress.value = false;
  }
}
