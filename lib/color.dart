import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = Color(0xffF86A30);
const surfaceColor = Color(0xffFFD8CB);
const greenColor = Color(0xff2FBC5F);
const blackColor = Color(0xff15181F);
const whiteColor = Colors.white;
const lightGreyColor = Color(0xffA1A1A1);

TextStyle boldText() =>
    GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 17);
TextStyle greyTextStyle() => GoogleFonts.poppins(color: Colors.grey);
TextStyle titleTextStyle() =>
    GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18 , color:  blackColor);

AppBar appBarStyle(String ab, BuildContext context) {
  return AppBar(
    toolbarHeight: 70,
    elevation: 0,
    backgroundColor: Colors.white,
    leading: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.arrow_back_ios_new,
        color: Colors.black,
        size: 20,
      ),
    ),
    centerTitle: true,
    title: Text(ab,
        style: GoogleFonts.poppins(
            fontSize: 17, fontWeight: FontWeight.w600, color: blackColor)),
  );
}
