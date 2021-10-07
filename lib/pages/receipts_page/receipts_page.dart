import 'package:flutter/material.dart';
import 'package:receipts_list_dummy_app/pages/add_receipt/add_receipt_page.dart';

class ReceiptsPage extends StatelessWidget {
  const ReceiptsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipts Demo App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('bla'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AddReceiptPage())),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
