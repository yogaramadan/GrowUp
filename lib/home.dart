import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growup/color.dart';
import 'package:growup/detailFunding.dart';
import 'package:growup/models/Fundings.dart';
import 'package:growup/notif.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String nameState = "Jhon Doe";
  @override
  void initState() {
    super.initState();
    loadName();
    fetchData();
  }

  void loadName() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'name';
    final name = prefs.getString(key) ?? 0;
    print('read: $name');
    setState(() {
      nameState = name.toString().replaceAll('"', "");
    });
  }

  Future<List<Fundings>> fetchData() async {
    var url = Uri.parse('https://growup.akutegar.com/api/fundings');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Fundings.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width2 = MediaQuery.of(context).size.width / 2.1;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 2,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: ListTile(
                title: Text("Hello, $nameState",
                    style: GoogleFonts.poppins(
                        color: blackColor, fontWeight: FontWeight.w600)),
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0xff7c94b6),
                    image: DecorationImage(
                      image: NetworkImage('http://i.imgur.com/QSev0hg.jpg'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                ),
                subtitle: Text("Welcome back",
                    style: GoogleFonts.poppins(color: const Color(0xff949494))),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NotificationPage()));
                  },
                  child: const CircleAvatar(
                    backgroundColor: surfaceColor,
                    child: Icon(
                      Icons.notifications,
                      color: primaryColor,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search all Funding...",
                    filled: true, //<-- SEE HERE
                    fillColor: const Color(0xffF5F5F5),
                    hintStyle:
                        GoogleFonts.poppins(color: const Color(0xffA1A4A9)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xffA1A4A9),
                    ),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent))),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Open Funding Now",
                style: titleTextStyle(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SizedBox(
                height: 300,
                child: FutureBuilder<List<Fundings>>(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (
                              BuildContext context,
                              int index,
                            ) {
                              var percetageProgress2 =
                                  snapshot.data![index].percetageProgress;
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: SizedBox(
                                  height: 300,
                                  // width: width2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // scrollDirection: Axis.horizontal,
                                    children: [
                                      SizedBox(
                                        height: 300,
                                        width: 200,
                                        child: Card(
                                          elevation: 0.9,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      snapshot
                                                          .data![index].image,
                                                      width: 181,
                                                    ),
                                                  )),
                                              Container(
                                                width: 200,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, top: 5),
                                                  child: Text(
                                                    snapshot.data![index].title,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 7, right: 7),
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  width: width2,
                                                  height: 9.5,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child:
                                                        LinearProgressIndicator(
                                                      value: percetageProgress2,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              primaryColor),
                                                      backgroundColor:
                                                          Color(0xffD6D6D6),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 15),
                                                        child: Text("Rp. ",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color:
                                                                        greenColor,
                                                                    fontSize:
                                                                        12))),
                                                    Text(
                                                      snapshot.data![index]
                                                          .current_amount
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: greenColor,
                                                              fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: primaryColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                        ),
                                                        height: 40,
                                                        width: width2,
                                                        child: Center(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              DetailFundingPage()));
                                                            },
                                                            child: Text(
                                                              "Fund",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          // color: greenColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }

                      return CircularProgressIndicator(
                        color: primaryColor,
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Open Funding Now",
                style: titleTextStyle(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 320,
                // width: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      child: Card(
                        elevation: 0.9,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Image.asset(
                                  'assets/images/barista_radius.png',
                                  width: 181,
                                )),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  "Warung Kopi Kita: Satu Cangkir Inpsirasi",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 7, right: 7),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: width2,
                                height: 9.5,
                                child: const ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: 0.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        primaryColor),
                                    backgroundColor: Color(0xffD6D6D6),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      "Rp. 50.000.000",
                                      style: GoogleFonts.poppins(
                                          color: greenColor, fontSize: 12),
                                    ),
                                  ),
                                  Text(
                                    "15 days left",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, top: 12, bottom: 8),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailFundingPage()));
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  height: 40,
                                  width: width2,
                                  child: Center(
                                    child: Text(
                                      "Funding",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        // color: greenColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
