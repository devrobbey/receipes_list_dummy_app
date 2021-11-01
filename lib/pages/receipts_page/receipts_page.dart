import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpx/gpx.dart';
import 'package:receipts_list_dummy_app/pages/add_receipt/add_receipt_page.dart';

class ReceiptsPage extends StatefulWidget {
  const ReceiptsPage({
    Key? key,
    required this.gpx,
  }) : super(key: key);

  final Gpx gpx;

  static const CameraPosition _kHamburgAlster = CameraPosition(
    target: LatLng(53.563838, 9.999523),
    zoom: 12.4746,
  );

  @override
  State<ReceiptsPage> createState() => _ReceiptsPageState();
}

class _ReceiptsPageState extends State<ReceiptsPage> {
  final Completer<GoogleMapController> _controller = Completer();

  Set<Polyline> _polylines = <Polyline>{};

  @override
  void initState() {
    super.initState();
    _polylines.add(Polyline(
      visible: true,
      color: Colors.blue,
      width: 5,
      polylineId: PolylineId('123'),
      points: widget.gpx.trks.first.trksegs.first.trkpts
          .map<LatLng>((trkpts) => LatLng(trkpts.lat!, trkpts.lon!))
          .toList(),
    ));
  }

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
            SizedBox(
              height: 300,
              child: GoogleMap(
                rotateGesturesEnabled: false,
                buildingsEnabled: false,
                mapType: MapType.hybrid,
                polylines: _polylines,
                initialCameraPosition: ReceiptsPage._kHamburgAlster,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  minY: 10,
                  maxY: 20,
                  minX: 0,
                  maxX: 10,
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: [
                        FlSpot(0, 11),
                        FlSpot(1, 12),
                        FlSpot(2, 11),
                        FlSpot(3, 13),
                        FlSpot(4, 17),
                        FlSpot(5, 11),
                        FlSpot(6, 11),
                        FlSpot(7, 11),
                        FlSpot(8, 11),
                        FlSpot(9, 11),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => AddReceiptPage())),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
