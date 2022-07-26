import 'package:flutter/material.dart';

enum DeleteType { single, all }

class DeleteDialog extends StatelessWidget {
  final Function onDelete;
  final DeleteType deleteType;

  const DeleteDialog(
      {Key? key, required this.onDelete, required this.deleteType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Note${deleteType == DeleteType.all ? 's' : ''}'),
      content: Text(
          'Are you sure you want to delete ${deleteType == DeleteType.single ? "this note" : "these notes"}?'),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(
            'Delete',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
          onPressed: () {
            onDelete.call();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
