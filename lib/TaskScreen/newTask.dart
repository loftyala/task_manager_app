import 'package:flutter/material.dart';
import 'package:task_manager_app/Data/Model/TaskStatusModel.dart';
import 'package:task_manager_app/Data/Model/TaskStatusCountModel.dart'; // Import the new model
import 'package:task_manager_app/TaskScreen/addNewTask.dart';
import 'package:task_manager_app/widget/taskCard.dart';
import '../Data/Model/TaskModel.dart';
import '../Data/Model/network_response.dart';
import '../Data/Model/taskListModel.dart';
import '../Data/Service/networkCaller.dart';
import '../Data/utils.dart';
import '../widget/taskSummaryCard.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskListInProgress = false;
  bool _getTaskStatusCountInProgress = false;

  List<TaskModel> _newTaskList = [];
  List<TaskStatusModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getTaskStatusCount(); // Call to fetch task status count
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNewTaskScreen()));
        },
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add, color: Colors.white70),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          _getNewTaskList();
          _getTaskStatusCount();
        },
        child: Column(
          children: [
            _buildSummarySection(),
            Expanded(
              child: Visibility(
                visible: !_getNewTaskListInProgress,
                replacement: Center(child: CircularProgressIndicator()),
                child: ListView.builder(
                  itemCount: _newTaskList.length,
                  itemBuilder: (context, index) {
                    return taskCard(taskModel: _newTaskList[index],
                      onRefreshList: _getNewTaskList,
                    ); // Passing TaskModel instance
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Visibility _buildSummarySection() {
    return Visibility(
      visible: !_getTaskStatusCountInProgress,
      replacement: Center(child: CircularProgressIndicator()),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _getTaskSummaryCardList(),
        ),
      ),
    );
  }
  List<taskSummaryCard> _getTaskSummaryCardList() {
    List<taskSummaryCard> taskSummaryCardList = [];
    for (TaskStatusModel t in _taskStatusCountList) {
      taskSummaryCardList.add(taskSummaryCard(title: t.sId!, count: t.sum ?? 0));
    }

    return taskSummaryCardList;
  }

  Future<void> _getNewTaskList() async {
    _newTaskList.clear();
    _getNewTaskListInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(url:Urls.newTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      _newTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getNewTaskListInProgress = false;
    setState(() {});
  }

  Future<void> _getTaskStatusCount() async {
    _taskStatusCountList.clear();
    _getTaskStatusCountInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(url:Urls.taskStatusCount); // Adjust URL if needed
    if (response.isSuccess) {
      final TaskStatusCountModel taskStatusCountModel = TaskStatusCountModel.fromJson(response.responseData);
      _taskStatusCountList = taskStatusCountModel.taskStatusCountList ?? []; // Ensure this is a list
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getTaskStatusCountInProgress = false;
    setState(() {});
  }
}
