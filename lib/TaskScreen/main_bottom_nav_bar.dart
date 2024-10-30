import 'package:flutter/material.dart';
import 'package:task_manager_app/TaskScreen/cancelledTask.dart';
import 'package:task_manager_app/TaskScreen/completedTask.dart';
import 'package:task_manager_app/TaskScreen/newTask.dart';
import 'package:task_manager_app/TaskScreen/progressTask.dart';
import 'package:task_manager_app/style/background.dart';
import 'package:task_manager_app/style/taskAppBar.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  int selectedIndex=0;

  final List<Widget> taskScreen=[
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
    ProgressTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),


      body: taskScreen[selectedIndex],
      bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (int index){
            setState(() {
              selectedIndex=index;
            });
          },
          destinations: [
        NavigationDestination(

            icon: Icon(Icons.new_label), label: 'New'),
        NavigationDestination(icon: Icon(Icons.check_box), label: 'Completed'),
        NavigationDestination(icon: Icon(Icons.close), label: 'Cancelled'),
        NavigationDestination(icon: Icon(Icons.access_time_filled), label: 'Progress'),
      ]),
    );
  }
}
