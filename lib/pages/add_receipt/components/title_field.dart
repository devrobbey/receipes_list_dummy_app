import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_receipt_bloc.dart';

class TitleField extends StatelessWidget {
  const TitleField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddReceiptBloc, AddReceiptState>(
        buildWhen: (_, __) => false,
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: const InputDecoration(
            label: Text('Title'),
          ),
          onChanged: (text) =>
              BlocProvider.of<AddReceiptBloc>(context).add(TitleChanged(text)),
        ),
      );
    });
  }
}
