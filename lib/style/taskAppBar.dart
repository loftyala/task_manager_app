import 'package:flutter/material.dart';
import 'package:task_manager_app/OnBoardingScreens/login.dart';
import 'package:task_manager_app/TaskScreen/Profile_page.dart';



class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.isProfileScreenOpen = false,
  });

  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isProfileScreenOpen) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
      },
      child: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rabbil Hasan',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'test@gmail.com',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (predicate) => false,
                );
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}