import 'package:flutter/material.dart';
import 'package:task_manager_app/Data/Model/TaskModel.dart';
import 'package:task_manager_app/widget/taskCard.dart';

import '../Data/Model/network_response.dart';
import '../Data/Model/taskLIstModel.dart';
import '../Data/Service/networkCaller.dart';
import '../Data/utils.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskListInProgress = false;
  List<TaskModel> _progressTaskList = [];

  @override
  void initState() {
    _getProgressTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getProgressTaskListInProgress,
      replacement: Center(child: CircularProgressIndicator()),
      child: RefreshIndicator(
        onRefresh: _getProgressTaskList,
        child: ListView.builder(
          itemCount: _progressTaskList.length,
          itemBuilder: (context, index) {
            return taskCard(
              onRefreshList: _getProgressTaskList,
              key: UniqueKey(),
              taskModel: _progressTaskList[index], // Passing a TaskModel instance
            );
          },
        ),
      ),
    );
  }

  Future<void> _getProgressTaskList() async {
    _progressTaskList.clear();
    _getProgressTaskListInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(Urls.progressTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _progressTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getProgressTaskListInProgress = false;
    setState(() {});
  }
}
