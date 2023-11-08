import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growup/color.dart';
import 'package:growup/tabBarFunding.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailFundingPage extends StatefulWidget {
  const DetailFundingPage({super.key});

  @override
  State<DetailFundingPage> createState() => _DetailFundingPageState();
}

class _DetailFundingPageState extends State<DetailFundingPage>
    with SingleTickerProviderStateMixin {
  final fundingNomimal = TextEditingController();
  bool isLoading = false;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this); // Set the number of tabs here
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void getPaymentSnapshot() async {
    setState(() {
      isLoading = true;
    });
    var data = {'amount': 10000, 'funding_id': 1};

    var url = Uri.https('growup.akutegar.com', 'api/pay');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final token = prefs.getString(key) ?? 0;
    print('read: $token');
    var response = await http
        .post(url, body: data, headers: {'Authorization': "Bearer $token"});

    print(response.body);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarStyle("Warung Kopi Kita", context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: double.infinity,
        child: FloatingActionButton.extended(
            backgroundColor: primaryColor,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                        // height: 1200,
                        child: Container(
                      // height: 1000,
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          )),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Funding Sekarang",
                              style: GoogleFonts.poppins(
                                  color: blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: fundingNomimal,
                                cursorColor: primaryColor,
                                decoration: const InputDecoration(
                                    fillColor: primaryColor,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                          color: primaryColor,
                                          width: 1.2,
                                        ))),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8,
                                    top: 12,
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                    right: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailFundingPage()));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Center(
                                        child: Text(
                                          "Funding",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom))
                        ],
                      ),
                    )),
                  );
                },
              );
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
            label: Text(
              "Support Project ini",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w600),
            )),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          Image.asset(
            'assets/images/barista_radius.png',
            width: double.infinity,
            height: 269,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Warung Kopi Kita: Satu Cangkir Inspirasi",
            style: titleTextStyle(),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: 160,
            height: 9.5,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                value: 0.5,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                backgroundColor: Color(0xffD9D9D9),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Text(
                  "Rp. 50.000.000",
                  style: TextStyle(color: greenColor),
                ),
                Text("  /  "),
                Text("Rp. 100.000,000"),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
                "Bantu perjuangan UKM untuk maju dan berkembang dengan berkontribusi pada kampanye penggalangan dana EmpowerUKM. Kami bertekad untuk meningkatkan daya saing dan peluang pertumbuhan bisnis kecil. Dukungan Anda akan membantu mewujudkan mimpi-mimpi kreatif para pengusaha lokal. Aplikasi kami, EmpowerUKM, memberikan platform aman dan transparan untuk menjalin ikatan yang berarti antara UKM yang berpotensi dengan para dermawan yang peduli. Mari bersama-sama memberdayakan UKM Indonesia dan menciptakan dampak positif bagi masyarakat. Jadilah bagian dari perubahan dan ikut berinvestasi dalam masa depan UKM yang cerah!"),
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    child: Text(
                      "Benefit mendukung projek ini",
                      style: TextStyle(color: Colors.grey[500]),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: greenColor),
                            // color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          size: 18,
                          Icons.check,
                          color: greenColor,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Mendapatkan premium service ")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: greenColor),
                            // color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          size: 18,
                          Icons.check,
                          color: greenColor,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Voucher diskon khusus"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: greenColor),
                            // color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          size: 18,
                          Icons.check,
                          color: greenColor,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Dan banyak lagi.."),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
          SizedBox(
            height: 70,
          )
        ],
      ),
    );
  }
}

class ModalFunding extends StatelessWidget {
  const ModalFunding({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                // height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
