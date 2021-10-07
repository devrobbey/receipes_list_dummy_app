import 'package:flutter/material.dart';
import 'package:receipts_list_dummy_app/pages/receipts_page/receipts_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receipts Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ReceiptsPage(),
    );
  }
}
