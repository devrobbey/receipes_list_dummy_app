import 'package:flutter/material.dart';
import 'package:receipts_list_dummy_app/pages/add_receipt/add_receipt_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ReceiptsPage(),
    );
  }
}
