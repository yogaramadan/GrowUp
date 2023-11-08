import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growup/Community_page.dart';
import 'package:growup/color.dart';
import 'package:growup/detailFunding.dart';
import 'package:growup/historyTransact.dart';
import 'package:growup/home.dart';
import 'package:growup/login.dart';
import 'package:growup/profile_page.dart';
import 'package:growup/register.dart';
import 'package:growup/video_page.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  // int index = 0;
  int _Selectedindex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const HistoryTransactionPage(),
    const CommunityPage(),
    const VideoPage(),
    const ProfilePage(),
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      _Selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_Selectedindex],
      bottomNavigationBar: Container(
        child: ClipRRect(
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedFontSize: 13,
            unselectedFontSize: 13,
            selectedItemColor: primaryColor,
            selectedLabelStyle: GoogleFonts.poppins(),
            unselectedItemColor: Color(0xff8F929B),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset('assets/images/home.png'),
                  label: "Home",
                  activeIcon: Image.asset(
                    'assets/images/home_active.png',
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/images/transaction.png'),
                  label: "Transaksi",
                  activeIcon: Image.asset(
                    'assets/images/transaction_active.png',
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/images/group.png'),
                  label: "Komunitas",
                  activeIcon: Image.asset(
                    'assets/images/group_active.png',
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/images/reels.png'),
                  label: "Video",
                  activeIcon: Image.asset(
                    'assets/images/reels_active.png',
                  )),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/images/profile.png'),
                  label: "Profile",
                  activeIcon: Image.asset(
                    'assets/images/profile_active.png',
                  )),
            ],
            currentIndex: _Selectedindex,
            onTap: _navigateBottomBar,
          ),
        ),
      ),
    );
  }
}
