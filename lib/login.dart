import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:growup/bottom.dart';
import 'package:growup/color.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    setState(() {
      isLoading = true;
    });

    var data = {
      'email': emailController.text,
      'password': passwordController.text
    };
    print(data);

    var url = Uri.https('growup.akutegar.com', 'api/auth/login');
    var response = await http.post(url, body: data);


    if (response.statusCode == 200) {
    var body = json.decode(response.body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      localStorage.setString('name', json.encode(body['name']));
      localStorage.setString('token', json.encode(body['access_token']));

         Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomPage()));
    } else {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
        content:  Text('Email dan password salah'),
      ));
    }

       setState(() {
      isLoading = false;
    });

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Login to GrowUp",
              style: titleTextStyle(),
            ),
          ),
          SizedBox(height: 25),
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
                decoration: const InputDecoration(
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
          SizedBox(
            height: 16,
          ),
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
                decoration: const InputDecoration(
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
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                "Forgot your password?",
                style:
                    TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30),
            child: GestureDetector(
              onTap: () {
                login();
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Center(
                  child:  isLoading == true ? CircularProgressIndicator(
                    color:  Colors.white,
                  ) : Text(
                    "Masuk Sekarang",
                    style: TextStyle(color: whiteColor, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Divider(
                  indent: 20,
                  endIndent: 10,
                  thickness: 2,
                ),
              ),
              Text("Atau"),
              Expanded(
                child: Divider(
                  indent: 10,
                  endIndent: 20,
                  thickness: 2,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE1E1E1)),
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.only(left: 10),
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
                    Text(
                      "Lanjut dengan akun Google",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE1E1E1)),
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.only(left: 10),
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
                    Text(
                      "Lanjut dengan akun Apple",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
     )),
    );
  }
}
