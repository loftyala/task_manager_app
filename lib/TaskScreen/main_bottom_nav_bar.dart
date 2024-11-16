import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:task_manager_app/TaskScreen/cancelledTask.dart';
import 'package:task_manager_app/TaskScreen/completedTask.dart';
import 'package:task_manager_app/TaskScreen/newTask.dart';
import 'package:task_manager_app/TaskScreen/progressTask.dart';
import 'package:task_manager_app/style/taskAppBar.dart';
import 'package:task_manager_app/Data/Model/TaskModel.dart';

class MainBottomNavBarScreen extends StatelessWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(), // Ensure TMAppBar is a valid AppBar widget
      body: Obx(() => TaskNavigationController.to.taskScreens[TaskNavigationController.to.selectedIndex.value]),
      bottomNavigationBar: Obx(
            () => NavigationBar(
          selectedIndex: TaskNavigationController.to.selectedIndex.value,
          onDestinationSelected: (int index) {
            TaskNavigationController.to.changeIndex(index);
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
      ),
    );
  }
}

class TaskNavigationController extends GetxController {
  static TaskNavigationController get to => Get.find();

  var selectedIndex = 0.obs;

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

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
