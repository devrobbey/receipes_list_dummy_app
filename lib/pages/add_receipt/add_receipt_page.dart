import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_receipt_bloc.dart';

class AddReceiptPage extends StatefulWidget {
  const AddReceiptPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddReceiptPage> createState() => _AddReceiptPageState();
}

class _AddReceiptPageState extends State<AddReceiptPage> {
  CameraController? controller;

  final Future<List<CameraDescription>> camerasFuture = availableCameras();

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddReceiptBloc>(
      create: (_) => AddReceiptBloc()..add(InitCam()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add receipt'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<List<CameraDescription>>(
                  future: camerasFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading cameras...');
                    } else if (snapshot.hasError) {
                      return const Text('Error loading camera');
                    } else if (snapshot.data!.isEmpty) {
                      return const Text('Your device seems to have no camera ...');
                    }

                    controller =
                        CameraController(snapshot.data![0], ResolutionPreset.max);

                    return FutureBuilder<void>(
                        future: controller!.initialize(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Text('Waiting for camera controller ...');
                          }
                          return ElevatedButton(
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => CameraPreview(controller!,))),
                            child: const Icon(Icons.camera_alt),
                          );
                        });
                  }),
            ],
          ),
        ),
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
