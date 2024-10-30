import 'package:flutter/material.dart';
import 'package:task_manager_app/style/taskAppBar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                child: TextField(
                  maxLines: 1,
                  decoration: inputDecoration("Enter the task name", "Title"),
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
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
          ],
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
}
