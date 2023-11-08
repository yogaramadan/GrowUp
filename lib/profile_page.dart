import 'package:flutter/material.dart';
import 'package:growup/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
                prefs.remove('name');

                 Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => OnBoardingScreen()));
              },
              child: Text("Logout"))
        ],
      ),
    );
  }
}
