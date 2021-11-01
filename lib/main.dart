import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpx/gpx.dart';
import 'package:receipts_list_dummy_app/pages/receipts_page/receipts_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final gpxString = await rootBundle.loadString('assets/map_graph_dummy.gpx');
  final gpx = GpxReader().fromString(gpxString);
  print('rtes: ${gpx.rtes}');
  print('trks: ${gpx.trks}');
  print('wpts: ${gpx.wpts}');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(gpx: gpx));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.gpx,}) : super(key: key);

  final Gpx gpx;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receipts Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReceiptsPage(gpx: gpx),
    );
  }
}
