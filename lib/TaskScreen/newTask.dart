import 'package:flutter/material.dart';
import 'package:task_manager_app/TaskScreen/addNewTask.dart';
import 'package:task_manager_app/widget/taskCard.dart';
import 'package:task_manager_app/widget/taskSummaryCard.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
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
      body: Column(
        children: [
          _buildSummarySection(),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return taskCard();
              },
            ),
          )
        ],
      ),
    );
  }

  Row _buildSummarySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        taskSummaryCard(title: 'New', count: 09),
        taskSummaryCard(title: 'Completed', count: 09),
        taskSummaryCard(title: 'Cancelled', count: 09),
        taskSummaryCard(title: 'Progress', count: 09),
      ],
    );
  }
}


