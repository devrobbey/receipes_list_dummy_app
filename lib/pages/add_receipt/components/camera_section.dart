import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_receipt_bloc.dart';

class CameraSection extends StatelessWidget {
  const CameraSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<AddReceiptBloc, AddReceiptState>(
          builder: (context, state) {
        return Column(
          children: [
            if (state is Valid && state.xFile != null)
              FutureBuilder<Uint8List>(
                future: File(state.xFile!.path).readAsBytes(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.memory(snapshot.data),
                    );
                  }
                  return Container();
                },
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: state is! Valid ||
                          (state is Valid && state.controller == null)
                      ? null
                      : () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CameraPreview(
                                state.controller!,
                              ))),
                  child: const Icon(Icons.camera_alt),
                ),
                ElevatedButton(
                  onPressed: () => BlocProvider.of<AddReceiptBloc>(context)
                      .add(UploadImageButtonPressed()),
                  child: const Icon(Icons.upload),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
