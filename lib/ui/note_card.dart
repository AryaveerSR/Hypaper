import 'package:flutter/material.dart';
import '../services/notes/notes.dart';

class NoteCard extends StatelessWidget {
  final Note displayNote;
  final Function()? onTap;
  final Function()? onDelete;
  final Function()? onEdit;
  final Function()? onSelect;

  const NoteCard(
      {Key? key,
      required this.displayNote,
      this.onTap,
      this.onDelete,
      this.onEdit, this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      onLongPress: () => onSelect?.call(),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        color: Theme.of(context).colorScheme.surface,
        elevation: 0,
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 8, right: 8),
          title: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              displayNote.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 2),
            child: Text(
              'Last Edited ${Note.timeAgo(displayNote.dateEdited)}',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () => onEdit?.call(),
                    constraints: const BoxConstraints(
                        maxWidth: 48,
                        maxHeight: 48,
                        minWidth: 48,
                        minHeight: 48),
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () => onDelete?.call(),
                    color: Theme.of(context).errorColor,
                    constraints: const BoxConstraints(
                        maxWidth: 48,
                        maxHeight: 48,
                        minWidth: 48,
                        minHeight: 48),
                    icon: const Icon(Icons.delete))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
