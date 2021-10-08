

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_receipt_bloc.dart';

class CameraSection extends StatelessWidget {
  const CameraSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddReceiptBloc, AddReceiptState>(
      builder: (context, state) {
        if (state is Uninitialized || state is CamInitInProgress) {
          return const Text('Cam init in progress ...');
        } else if (state is CamInitError) {
          return const Text('Cam init error or no cam available');
        } else if (state is CamInitialised) {
          return ElevatedButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => CameraPreview(state.controller,))),
            child: const Icon(Icons.camera_alt),
          );
        }
        return Container();
      }
    );
  }

}