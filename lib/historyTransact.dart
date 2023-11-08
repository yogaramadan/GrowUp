import 'package:flutter/material.dart';
import 'package:growup/color.dart';

class HistoryTransactionPage extends StatefulWidget {
  const HistoryTransactionPage({super.key});

  @override
  State<HistoryTransactionPage> createState() => _HistoryTransactionPageState();
}

class _HistoryTransactionPageState extends State<HistoryTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarStyle("Riwayat Transaksi", context),
      body: ListView(
        children: [],
      ),
    );
  }
}
