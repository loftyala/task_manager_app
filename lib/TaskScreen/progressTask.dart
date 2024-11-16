import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/Data/Model/TaskModel.dart';
import 'package:task_manager_app/Data/Model/network_response.dart';
import 'package:task_manager_app/Data/Model/taskLIstModel.dart';
import 'package:task_manager_app/Data/Service/networkCaller.dart';
import 'package:task_manager_app/Data/utils.dart';
import 'package:task_manager_app/widget/taskCard.dart';

class ProgressTaskController extends GetxController {
  final isLoading = false.obs;
  final progressTaskList = <TaskModel>[].obs;

  Future<void> fetchProgressTaskList() async {
    isLoading.value = true;

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.progressTaskList);

    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);
      progressTaskList.value = taskListModel.taskList ?? [];
    } else {
      Get.snackbar("Error", response.errorMessage, snackPosition: SnackPosition.BOTTOM);
    }

    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchProgressTaskList();
  }
}

class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProgressTaskController controller = Get.put(ProgressTaskController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: controller.fetchProgressTaskList,
        child: ListView.builder(
          itemCount: controller.progressTaskList.length,
          itemBuilder: (context, index) {
            return taskCard(
              onRefreshList: controller.fetchProgressTaskList,
              key: UniqueKey(),
              taskModel: controller.progressTaskList[index],
            );
          },
        ),
      );
    });
  }
}
