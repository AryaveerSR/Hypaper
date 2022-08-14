import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final Function onDelete;
  final bool deleteMultiple;

  const DeleteDialog(
      {Key? key, required this.onDelete, required this.deleteMultiple})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('Delete Note${deleteMultiple ? 's' : ''}'),
      content: Text(
          'Are you sure you want to delete ${deleteMultiple ? "these notes" : "this note"}?'),
      actions: [
        TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context)),
        TextButton(
          child: Text('Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error)),
          onPressed: () {
            onDelete();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
