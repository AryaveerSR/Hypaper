import 'package:flutter/material.dart';
import '../services/notes/notes.dart';

class NoteCard extends StatelessWidget {
  final Note displayNote;
  final Function()? onTap;
  final Function()? onDelete;
  final Function()? onEdit;

  const NoteCard(
      {Key? key,
      required this.displayNote,
      this.onTap,
      this.onDelete,
      this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        elevation: 0,
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(
                  left: 16, right: 16, top: 12, bottom: 2),
              title: Text(
                displayNote.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Last Edited ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    Note.timeAgo(displayNote.dateEdited),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                displayNote.content,
                style: Theme.of(context).textTheme.bodyText2,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
          ],
        ),
      ),
    );
  }
}
