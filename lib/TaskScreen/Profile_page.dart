import 'package:flutter/material.dart';
import 'package:task_manager_app/style/style.dart';
import 'package:task_manager_app/style/taskAppBar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(
        isProfileScreenOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text("Update Profile",style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 20,),
              _buildPhotoPicker(),
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: inputDecoration("Enter Email", "Email",
                        Icon(Icons.mark_email_read_outlined)),
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: inputDecoration("Enter your first name", "First Name",
                        Icon(Icons.person_outlined)),
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: inputDecoration("Enter your Last name", " Last Name",
                        Icon(Icons.person_outlined)),
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: inputDecoration("Enter your Phone Number", "Phone",
                        Icon(Icons.phone_android_outlined)),
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: inputDecoration("Enter your password", "Password",
                        Icon(Icons.password)),
                  ),
                ),
              ),
              Card(
                shadowColor: Colors.deepOrange,
                elevation: 10,
                color: Colors.deepOrange,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text("Update", style: TextStyle(color: Colors.white)),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Container _buildPhotoPicker() {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color: Colors.white,
    ),
    child: Row(
      children: [
        Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            "Photo",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.camera_alt, color: Colors.grey),
          onPressed: () {
            // Implement photo selection logic here
          },
        ),
      ],
    ),
  );
}

}
