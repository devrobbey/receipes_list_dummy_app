

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../add_receipt_bloc.dart';

class IngredientsSection extends StatelessWidget {
  const IngredientsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddReceiptBloc, AddReceiptState>(
        buildWhen: (_, __) => false,
        builder: (context, state) {
          return TextField(
            decoration: const InputDecoration(
              label: Text('Ingredients'),
            ),
            onChanged: (text) =>
                BlocProvider.of<AddReceiptBloc>(context).add(TitleChanged(text)),
          );
        });
  }

}