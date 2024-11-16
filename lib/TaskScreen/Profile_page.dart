import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/style/style.dart';
import 'package:task_manager_app/style/taskAppBar.dart';

import '../Controller/auth_controller.dart';
import '../Data/Model/network_response.dart';
import '../Data/Model/userModel.dart';
import '../Data/Service/networkCaller.dart';
import '../Data/utils.dart';

class ProfileController extends GetxController {
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isUpdatingProfile = false.obs;
  final selectedImage = Rxn<XFile>();

  @override
  void onInit() {
    super.onInit();
    setUserData();
  }

  void setUserData() {
    emailController.text = AuthController.userData?.email ?? '';
    firstNameController.text = AuthController.userData?.firstName ?? '';
    lastNameController.text = AuthController.userData?.lastName ?? '';
    phoneController.text = AuthController.userData?.mobile ?? '';
  }

  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImage.value = pickedImage;
    }
  }

  Future<void> updateProfile(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    isUpdatingProfile.value = true;

    Map<String, dynamic> requestBody = {
      "email": emailController.text.trim(),
      "firstName": firstNameController.text.trim(),
      "lastName": lastNameController.text.trim(),
      "mobile": phoneController.text.trim(),
    };

    if (passwordController.text.isNotEmpty) {
      requestBody['password'] = passwordController.text;
    }

    if (selectedImage.value != null) {
      List<int> imageBytes = await selectedImage.value!.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      requestBody['photo'] = convertedImage;
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfile,
      body: requestBody,
    );

    isUpdatingProfile.value = false;

    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(requestBody);
      AuthController.saveUserData(userModel);
      showSnackBarMessage(context, 'Profile has been updated!', true);
    } else {
      showSnackBarMessage(context, response.errorMessage, false);
    }
  }

  String getSelectedPhotoTitle() {
    return selectedImage.value != null ? selectedImage.value!.name : 'Select Photo';
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: TMAppBar(
        isProfileScreenOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    "Update Profile",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: controller.pickImage,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8), color: Colors.white),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Photo',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Obx(() => Text(controller.getSelectedPhotoTitle())),
                      ],
                    ),
                  ),
                ),
                _buildTextField(controller.emailController, "Email", "Enter Email",
                    Icon(Icons.mark_email_read_outlined), false),
                _buildTextField(controller.firstNameController, "First Name", "Enter your first name",
                    Icon(Icons.person_outlined), true),
                _buildTextField(controller.lastNameController, "Last Name", "Enter your Last name",
                    Icon(Icons.person_outlined), true),
                _buildTextField(controller.phoneController, "Phone", "Enter your Phone Number",
                    Icon(Icons.phone_android_outlined), true),
                _buildTextField(controller.passwordController, "Password", "Enter your password",
                    Icon(Icons.password), true),
                const SizedBox(height: 16),
                Obx(() => Visibility(
                  visible: !controller.isUpdatingProfile.value,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(
                    onPressed: () => controller.updateProfile(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Update", style: TextStyle(color: Colors.white)),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint,
      Icon prefixIcon, bool enabled) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          enabled: enabled,
          decoration: inputDecoration(hint, label, prefixIcon),
        ),
      ),
    );
  }
}
