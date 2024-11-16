import 'package:flutter/material.dart';
import 'package:task_manager_app/Data/Model/TaskStatusModel.dart';
import 'package:task_manager_app/Data/Model/TaskStatusCountModel.dart';
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
  bool _isLoadingTasks = false;
  bool _isLoadingTaskStatus = false;
  List<TaskModel> _newTaskList = [];
  List<TaskStatusModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoadingTasks = true;
      _isLoadingTaskStatus = true;
    });

    await Future.wait([
      _getNewTaskList(),
      _getTaskStatusCount(),
    ]);

    setState(() {
      _isLoadingTasks = false;
      _isLoadingTaskStatus = false;
    });
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
        onRefresh: _refreshData,
        child: Column(
          children: [
            _buildSummarySection(),
            Expanded(
              child: _isLoadingTasks
                  ? Center(child: CircularProgressIndicator())
                  : _newTaskList.isEmpty
                  ? Center(child: Text('No tasks found'))
                  : ListView.builder(
                itemCount: _newTaskList.length,
                itemBuilder: (context, index) {
                  return taskCard(
                    taskModel: _newTaskList[index],
                    onRefreshList: _getNewTaskList,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return _isLoadingTaskStatus
        ? Center(child: CircularProgressIndicator())
        : _taskStatusCountList.isEmpty
        ? Center(child: Text('No task status data available'))
        : SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _taskStatusCountList
            .map((status) => taskSummaryCard(title: status.sId!, count: status.sum ?? 0))
            .toList(),
      ),
    );
  }

  Future<void> _getNewTaskList() async {
    final response = await NetworkCaller.getRequest(url: Urls.newTaskList);
    if (response.isSuccess) {
      final taskListModel = TaskListModel.fromJson(response.responseData);
      setState(() {
        _newTaskList = taskListModel.taskList ?? [];
      });
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  Future<void> _getTaskStatusCount() async {
    final response = await NetworkCaller.getRequest(url: Urls.taskStatusCount);
    if (response.isSuccess) {
      final taskStatusCountModel = TaskStatusCountModel.fromJson(response.responseData);
      setState(() {
        _taskStatusCountList = taskStatusCountModel.taskStatusCountList ?? [];
      });
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
