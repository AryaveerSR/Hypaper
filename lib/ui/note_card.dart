import 'package:flutter/material.dart';

import '../services/notes.dart';
import 'tag_chip.dart';

class NoteCard extends StatelessWidget {
  final Note displayNote;
  final Function()? onTap;
  final Function()? onDelete;
  final Function()? onSelect;
  final double clearance;
  final bool isSelected;

  const NoteCard(
      {Key? key,
      required this.displayNote,
      required this.isSelected,
      this.onTap,
      this.onDelete,
      this.onSelect,
      this.clearance = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      onLongPress: () => onSelect?.call(),
      child: Card(
        margin: EdgeInsets.only(bottom: clearance),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline)),
        color: isSelected
            ? Theme.of(context).colorScheme.secondaryContainer
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                title: Text(displayNote.title, overflow: TextOverflow.ellipsis),
                subtitle:
                    Text(displayNote.content, overflow: TextOverflow.ellipsis)),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(width: 4),
                          ...(displayNote.tags!
                              .map((e) => TagChip(label: e))
                              .map((tag) => Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: tag))
                              .toList())
                        ],
                      ),
                    ),
                  ),
                  Row(children: [
                    TextButton(
                        child: const Text('View'),
                        onPressed: () => onTap?.call()),
                    const SizedBox(width: 8),
                    TextButton(
                      child: Text('Delete',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error)),
                      onPressed: () => onDelete?.call(),
                    ),
                    const SizedBox(width: 8)
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
