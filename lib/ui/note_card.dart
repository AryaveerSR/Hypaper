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
    return Card(
      elevation: 1,
      child: ListTile(
          tileColor: Theme.of(context).colorScheme.surface,
          contentPadding:
              const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
          onTap: () => onTap?.call(),
          title: Text(
            displayNote.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            displayNote.content,
            style: Theme.of(context).textTheme.bodyText2,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          trailing: IconButton(
              onPressed: () => onDelete?.call(),
              color: Theme.of(context).errorColor,
              constraints: const BoxConstraints(
                  maxWidth: 48, maxHeight: 48, minWidth: 48, minHeight: 48),
              icon: const Icon(Icons.delete))),
    );
  }
}
