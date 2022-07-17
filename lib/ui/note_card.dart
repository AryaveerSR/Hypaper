import 'package:flutter/material.dart';
import '../services/notes/notes.dart';

class NoteCard extends StatelessWidget {
  final Note displayNote;
  Function()? onTap;
  Function()? onDelete;
  NoteCard({Key? key, required this.displayNote, this.onTap, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(displayNote.title),
                  Text(displayNote.dateCreated.toString()),
                  Text(displayNote.content),
                ],
              ),
              IconButton(
                  onPressed: onDelete,
                  color: Theme.of(context).errorColor,
                  icon: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
