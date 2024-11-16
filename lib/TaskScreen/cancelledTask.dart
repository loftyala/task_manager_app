import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX for reactive state management and snackbar
import 'package:task_manager_app/Data/Model/TaskModel.dart';
import 'package:task_manager_app/widget/taskCard.dart';

import '../Data/Model/network_response.dart';
import '../Data/Model/taskLIstModel.dart';
import '../Data/Service/networkCaller.dart';
import '../Data/utils.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  var _getCancelledTaskListInProgress = false.obs; // Observable for loading state
  var _cancelledTaskList = <TaskModel>[].obs; // Observable list of tasks

  @override
  void initState() {
    _getCancelledTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
      visible: !_getCancelledTaskListInProgress.value,
      replacement: Center(child: CircularProgressIndicator()),
      child: RefreshIndicator(
        onRefresh: _getCancelledTaskList,
        child: ListView.builder(
          itemCount: _cancelledTaskList.length,
          itemBuilder: (context, index) {
            return taskCard(
              key: UniqueKey(),
              onRefreshList: _getCancelledTaskList,
              taskModel: _cancelledTaskList[index], // Passing a TaskModel instance
            );
          },
        ),
      ),
    ));
  }

  Future<void> _getCancelledTaskList() async {
    _cancelledTaskList.clear();
    _getCancelledTaskListInProgress.value = true;

    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.cancelledTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _cancelledTaskList.assignAll(taskListModel.taskList ?? []);
    } else {
      Get.snackbar('Error', response.errorMessage, snackPosition: SnackPosition.BOTTOM, colorText: Colors.white, backgroundColor: Colors.red);
    }
    _getCancelledTaskListInProgress.value = false;
  }
}
