import 'package:flutter/material.dart';
import 'package:growup/color.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarStyle("Notifikasi", context),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              // height: 80,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                // color: primaryColor,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.factory),
                    ),
                    title: Text("Warung Kopi Kita"),
                    subtitle: InkWell(
                      child: Text(
                          "“Goals reached!, here’s your reward! forms.gle/uhuhuDp6uAcQG3WS6”"),
                    ),
                    trailing: Text("15:36"),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              // height: 80,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.factory),
                    ),
                    title: Text("Warung Kopi Kita"),
                    subtitle: InkWell(
                      child: Text(
                        "“Goals reached!, here’s your reward! forms.gle/uhuhuDp6uAcQG3WS6”",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                    trailing: Text("15:36"),
                    // titleTextStyle:
                    //     TextStyle(color: Colors.grey[400], fontSize: 16),
                    // leadingAndTrailingTextStyle:
                    //     TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
