import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growup/bottom.dart';
import 'package:growup/bottom.dart';
import 'package:growup/color.dart';
import 'package:growup/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void register() async {
    setState(() {
      isLoading = true;
    });

    var data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text
    };
    print(data);

    var url = Uri.https('growup.akutegar.com', 'api/auth/register');
    var response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      localStorage.setString('name', json.encode(body['name']));
      localStorage.setString('token', json.encode(body['access_token']));

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Ups sepertinya pendaftaran anda gagal'),
      ));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Daftar to GrowUp",
                style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Mari kita Tumbuh bersama  ",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffA9A9A9))),
          ),
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 5),
            child: Text(
              "Nama",
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 25),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: nameController,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                    fillColor: primaryColor,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 1.2,
                        ))),
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 5),
            child: Text(
              "Alamat email",
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 25),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: emailController,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                    fillColor: primaryColor,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 1.2,
                        ))),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 5),
            child: Text(
              "Password",
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 25),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: passwordController,
                cursorColor: primaryColor,
                obscureText: true,
                decoration: InputDecoration(
                    fillColor: primaryColor,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 1.2,
                        ))),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 20),
          //   child: Text(
          //     "Forgot your password?",
          //     style:
          //         TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: GestureDetector(
              onTap: () {
                register();
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 40,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Center(
                  child: isLoading == true
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Daftar Sekarang",
                          style: TextStyle(color: whiteColor, fontSize: 16),
                        ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(" Sudah mempunyai akun ? ", style: GoogleFonts.poppins()),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(" Login Sekarang",
                    style: GoogleFonts.poppins(
                        color: primaryColor, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              const Expanded(
                child: Divider(
                  indent: 20,
                  endIndent: 10,
                  thickness: 2,
                ),
              ),
              const Text("Atau"),
              const Expanded(
                child: Divider(
                  indent: 10,
                  endIndent: 20,
                  thickness: 2,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BottomPage()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE1E1E1)),
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/google.png',
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 9.5,
                    ),
                    const Text(
                      "Lanjut dengan akun Google",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BottomPage()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE1E1E1)),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/Apple.png',
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 9.5,
                    ),
                    const Text(
                      "Lanjut dengan akun Apple",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
