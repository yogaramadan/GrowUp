import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growup/bottom.dart';
import 'package:growup/color.dart';
import 'package:growup/home.dart';
import 'package:growup/login.dart';
import 'package:growup/register.dart';
import 'package:intro_slider/intro_slider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;

  List<String> images = [
    "assets/images/onboarding_big.png",
    "assets/images/onboarding_2.png",
    "assets/images/onboarding_3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          // Positioned.fill(child: Image.asset('assets/images/onboarding_1.png',width:  double.infinity , fit: BoxFit.cover,)),
          Positioned.fill(
              child: IntroSlider(
            isAutoScroll: true,
            isShowDoneBtn: false,
            isShowNextBtn: false,
            isShowSkipBtn: false,
            isShowPrevBtn: false,
            isLoopAutoScroll: true,
            listCustomTabs: List<Widget>.generate(
              images.length,
              (index) => Image.asset(images[index],
              alignment:  Alignment.center,
                  width: double.infinity, fit: BoxFit.cover),
            ),
            onTabChangeCompleted: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          )),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: LinearProgressIndicator(
                          color: primaryColor,
                          value: (currentIndex + 1 / images.length) * 1,
                          backgroundColor: Color(0xffF2F2F2),
                        ),
                      ),

                      SizedBox(
                        height: 16,
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xffFFD8CB),
                            borderRadius: BorderRadius.circular(17)),
                        child: Text(
                          "Let's GrowUp",
                          style: GoogleFonts.poppins(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Dapatkan Pendanaan untuk UKM Anda!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),

                      Text(
                        " Dapatkan pendanaan dengan cepat dan tingkatkan pertumbuhan bisnis Anda",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Color(0xffA9A9A9),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      //  ElevatedButton(
                      //   onPressed: () {},
                      //   child: Container(
                      //     child: Text("Start Funding Now"),
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //         color: primaryColor,
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(16))),
                      //   ),
                      // )

                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 30),
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Center(
                              child: Text(
                                "Start Funding Now",
                                style:
                                    TextStyle(color: whiteColor, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
