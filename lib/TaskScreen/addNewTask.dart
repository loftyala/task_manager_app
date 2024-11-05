import 'package:flutter/material.dart';
import 'package:task_manager_app/style/taskAppBar.dart';

import '../Data/Model/network_response.dart';
import '../Data/Service/networkCaller.dart';
import '../Data/utils.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop,result){
        if(didPop){
          return;
        }
      },
      child: Scaffold(
        appBar: TMAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 42),
                Text('Add New Task', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 25),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _titleController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Title is required';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: inputDecoration("Enter the task name", "Title"),
                      style: TextStyle(
                        fontSize: 20, // Set the desired font size
                        fontWeight: FontWeight.bold, // Set the font weight to bold
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _descriptionController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Description is required';
                        }
                        return null;
                      },
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: inputDecoration("Enter task description", "Description"),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  shadowColor: Colors.deepOrange,
                  elevation: 10,
                  color: Colors.deepOrange,
                  child: Visibility(
                    visible:inProgress==false ,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(

                      onPressed: () {
                        // Add your task submission logic here
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text("Add Task", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hintText, String labelText) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.deepOrange),
      border: InputBorder.none,
    );
  }
  void onTapAddTaskButton() {
    if (_formKey.currentState!.validate()) {
      addNewTask();
    }
  }
    Future<void> addNewTask() async {
      inProgress=true;
      setState(() {});
      final NetworkResponse response = await NetworkCaller.postRequest(
        Urls.addTask,
        body: {
          'title': _titleController.text,
          'description': _descriptionController.text,
          "status":"New"
        },
      );
      inProgress=false;
      setState(() {});
      if (response.isSuccess) {
        _clearTextFields();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task added successfully")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.errorMessage)));
      }
    }
    void _clearTextFields() {
      _titleController.clear();
      _descriptionController.clear();
    }
}
