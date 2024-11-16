import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/style/taskAppBar.dart';

import '../Data/Model/network_response.dart';
import '../Data/Service/networkCaller.dart';
import '../Data/utils.dart';

class AddNewTaskScreen extends StatelessWidget {
  const AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddTaskController>(
      init: AddTaskController(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: TMAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 42),
                  Text('Add New Task', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 25),
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controller.titleController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Title is required';
                          }
                          return null;
                        },
                        maxLines: 1,
                        decoration: inputDecoration("Enter the task name", "Title"),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controller.descriptionController,
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
                  const SizedBox(height: 10),
                  Card(
                    shadowColor: Colors.deepOrange,
                    elevation: 10,
                    color: Colors.deepOrange,
                    child: Obx(() => Visibility(
                      visible: !controller.inProgress.value,
                      replacement: const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: controller.onTapAddTaskButton,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Add Task", style: TextStyle(color: Colors.white)),
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  InputDecoration inputDecoration(String hintText, String labelText) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.deepOrange),
      border: InputBorder.none,
    );
  }
}

class AddTaskController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final inProgress = false.obs;

  void onTapAddTaskButton() {
    if (formKey.currentState!.validate()) {
      addNewTask();
    }
  }

  Future<void> addNewTask() async {
    inProgress.value = true;
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.addTask,
      body: {
        'title': titleController.text,
        'description': descriptionController.text,
        "status": "New"
      },
    );
    inProgress.value = false;
    if (response.isSuccess) {
      _clearTextFields();
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text("Task added successfully")),
      );
      Get.back(result: true);
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text(response.errorMessage)),
      );
    }
  }

  void _clearTextFields() {
    titleController.clear();
    descriptionController.clear();
  }
}
