import 'package:final_exam/blocs/expanse_bloc.dart';
import 'package:final_exam/blocs/expanse_event.dart';
import 'package:final_exam/data/models/expanse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDialog extends StatelessWidget {
  AddDialog({super.key, required this.type});

  final String type;
  final valueController = TextEditingController();
  final categoryController = TextEditingController();
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      title: Text("Add $type"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: valueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Amount",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Category",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Comment",
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<ExpanseBloc>().add(AddExpanseEvent(
                    expanse: ExpanseModel(
                  id: 1,
                  value: double.parse(valueController.text),
                  category: categoryController.text,
                  time: DateTime.now(),
                  comment: commentController.text,
                )));
          },
          child: Text("Add $type"),
        ),
      ],
    );
  }
}
