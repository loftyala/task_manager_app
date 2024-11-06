import 'package:flutter/material.dart';
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
  bool _getCancelledTaskListInProgress = false;
  List<TaskModel> _cancelledTaskList = [];

  @override
  void initState() {
    _getCancelledTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCancelledTaskListInProgress,
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
    );
  }

  Future<void> _getCancelledTaskList() async {
    _cancelledTaskList.clear();
    _getCancelledTaskListInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(url:Urls.cancelledTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _cancelledTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getCancelledTaskListInProgress = false;
    setState(() {});
  }
}
