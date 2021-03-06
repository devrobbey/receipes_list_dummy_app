import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipts_list_dummy_app/pages/add_receipt/components/ingredients_section.dart';
import 'package:receipts_list_dummy_app/pages/add_receipt/components/subtitle_field.dart';
import 'package:receipts_list_dummy_app/pages/add_receipt/components/title_field.dart';
import 'package:receipts_list_dummy_app/pages/add_receipt/components/working_steps_section.dart';

import 'add_receipt_bloc.dart';
import 'components/camera_section.dart';

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
            children: const <Widget>[
              CameraSection(),
              TitleField(),
              SubtitleField(),
              IngredientsSection(),
              WorkingStepsSection(),
            ],
          ),
        ),
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          tooltip: 'Increment',
          child: Icon(Icons.check),
        ),
      ),
    );
  }
}
