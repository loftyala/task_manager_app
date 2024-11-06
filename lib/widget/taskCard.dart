import 'package:flutter/material.dart';
import 'package:task_manager_app/Data/Model/TaskModel.dart';

import '../Data/Model/network_response.dart';
import '../Data/Service/networkCaller.dart';
import '../Data/utils.dart';

class taskCard extends StatefulWidget {
  const taskCard({super.key, required this.taskModel, required this.onRefreshList});

  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  State<taskCard> createState() => _taskCardState();
}

class _taskCardState extends State<taskCard> {
  String _selectedStatus = '';
bool _changeStatusInProgress = false;
bool _deleteTaskInProgress = false;

  @override
  void initState() {
    _selectedStatus = widget.taskModel.status ?? "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.taskModel.title ?? "",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            widget.taskModel.description ?? "",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(widget.taskModel.createdDate ?? ""),
          Row(
            children: [
              _TaskStatusChip(widget.taskModel.status),
              Spacer(),
              Visibility(
                visible: _changeStatusInProgress==false,
                replacement: Center(child: CircularProgressIndicator()),
                child: IconButton(
                  onPressed: _onTapEditButton,
                  icon: Icon(Icons.edit_note, color: Colors.deepOrange),
                ),
              ),
              Visibility(
                visible: _deleteTaskInProgress==false,
                replacement: Center(child: CircularProgressIndicator()),
                child: IconButton(
                  onPressed: () => _onTapDeleteButton(_selectedStatus),
                  icon:  Icon(Icons.delete, color: Colors.deepOrange),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onTapEditButton() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ["New", "Completed", "Cancelled", "Progress"].map((e) {
              return ListTile(
                onTap: () {
                  _changeStatus(e);
                  Navigator.pop(context);
                },
                title: Text(e),
                selected: _selectedStatus == e,
                selectedTileColor: Colors.deepOrange,
                trailing: _selectedStatus==e?Icon(Icons.check):null,
              );
            }).toList(),
          ),
          title: Text("Edit Status"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Okay"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onTapDeleteButton(String newStatus) async {
    _deleteTaskInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
       url:  Urls.deleteTask(widget.taskModel.sId!, newStatus));
    if (response.isSuccess) {
      widget.onRefreshList();
    } else {
      _deleteTaskInProgress = false;
      setState(() {});
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  Chip _TaskStatusChip(String? status) {
    return Chip(
      backgroundColor: Colors.white,
      label: Text(
        widget.taskModel.status ?? "",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.deepOrange, width: 2),
      ),
    );
  }
  Future<void> _changeStatus(String newStatus) async {
    _changeStatusInProgress = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(
        url:  Urls.changeStatus(widget.taskModel.sId!, newStatus));
    if (response.isSuccess) {
     widget.onRefreshList();
    } else {
      _changeStatusInProgress = false;
      setState(() {});
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
