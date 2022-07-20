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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Theme.of(context).colorScheme.surface,
        elevation: 2,
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(left: 16, right: 16),
              title: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  displayNote.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 2),
                child: Text(
                  'Last Edited ${Note.timeAgo(displayNote.dateEdited)}',
                  style: Theme.of(context).textTheme.bodySmall,
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, bottom: 12, right: 16, top: 4),
              child: Text(
                displayNote.content,
                style: Theme.of(context).textTheme.bodyText2,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
