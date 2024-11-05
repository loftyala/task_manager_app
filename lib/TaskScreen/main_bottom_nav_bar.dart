import 'package:flutter/material.dart';
import 'package:task_manager_app/TaskScreen/cancelledTask.dart';
import 'package:task_manager_app/TaskScreen/completedTask.dart';
import 'package:task_manager_app/TaskScreen/newTask.dart';
import 'package:task_manager_app/TaskScreen/progressTask.dart';
import 'package:task_manager_app/style/taskAppBar.dart';
import 'package:task_manager_app/Data/Model/TaskModel.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  int selectedIndex = 0;

  final List<Widget> taskScreens = [
    NewTaskScreen(
      key: UniqueKey(),
      taskModel: TaskModel(
        title: 'New Task',
        description: 'Description of the new task',
        createdDate: '2024-11-05',
        status: 'New',
      ),
    ),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(), // Ensure TMAppBar is a valid AppBar widget
      body: taskScreens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.new_releases),
            label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel),
            label: 'Cancelled',
          ),
          NavigationDestination(
            icon: Icon(Icons.hourglass_bottom),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}
