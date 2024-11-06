import 'package:flutter/material.dart';
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

  bool _getCompletedTaskListInProgress = false;
  List<TaskModel> _CompletedTaskList = [];

  @override
  void initState() {
    _getCompletedTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCompletedTaskListInProgress,
      replacement: Center(child: CircularProgressIndicator()),
      child: RefreshIndicator(
        onRefresh: _getCompletedTaskList,
        child: ListView.builder(
          itemCount: _CompletedTaskList.length,
          itemBuilder: (context, index) {
            return taskCard(
              onRefreshList:_getCompletedTaskList ,
              key: UniqueKey(),
              taskModel: _CompletedTaskList[index], // Passing a TaskModel instance
            );
          },
        ),
      ),
    );
  }
  Future<void> _getCompletedTaskList() async {
    _CompletedTaskList.clear();
    _getCompletedTaskListInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(url:Urls.completedTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _CompletedTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getCompletedTaskListInProgress = false;
    setState(() {});
  }
}
