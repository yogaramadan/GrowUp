import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growup/bottom.dart';
import 'package:growup/color.dart';
import 'package:growup/home.dart';
import 'package:growup/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashTime();
  }

  SplashTime() async {
    var duration = new Duration(seconds: 3);
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final token = prefs.getString(key) ?? 0;
    print(token);
    if (token == 0) {
      return new Timer(duration, route);
    } else {
      return new Timer(duration, routeEligble);
    }
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));
  }

  routeEligble() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => BottomPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_splash.png',
              width: 227,
            ),
            const SizedBox(
              height: 16,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            ),
            const SizedBox(
              height: 16,
            ),

            // Text("Le’ts Grow Together ",
            //     style: GoogleFonts.poppins(
            //         color: Colors.white,
            //         fontWeight: FontWeight.w600,
            //         fontSize: 23))
          ],
        ),
      )),
    );
  }
}
