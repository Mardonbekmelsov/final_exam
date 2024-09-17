import 'package:final_exam/blocs/expanse_bloc.dart';
import 'package:final_exam/blocs/expanse_event.dart';
import 'package:final_exam/data/models/expanse_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditExpanseDialog extends StatefulWidget {
  EditExpanseDialog({super.key, required this.expanse});

  final ExpanseModel expanse;

  @override
  State<EditExpanseDialog> createState() => _EditExpanseDialogState();
}

class _EditExpanseDialogState extends State<EditExpanseDialog> {
  final valueController = TextEditingController();

  final categoryController = TextEditingController();

  final commentController = TextEditingController();

  @override
  void initState() {
    setState(() {
      valueController.text = widget.expanse.value.toString();
      categoryController.text = widget.expanse.category;
      commentController.text = widget.expanse.comment;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      title: const Text("Edit Expanse"),
      content: Column(
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
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<ExpanseBloc>().add(UpdateExpanseEvent(
                id: widget.expanse.id,
                expanse: ExpanseModel(
                  id: 1,
                  value: double.parse(valueController.text),
                  category: categoryController.text,
                  time: DateTime.now(),
                  comment: commentController.text,
                )));
          },
          child: const Text("Update Expanse"),
        ),
      ],
    );
  }
}
