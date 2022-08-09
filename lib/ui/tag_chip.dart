import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String label;
  final bool isHighlighted;
  final VoidCallback? onRemove;

  const TagChip(
      {Key? key,
      required this.label,
      this.isHighlighted = false,
      this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      onDeleted: onRemove,
      deleteIcon: const Icon(Icons.close),
      label: Text(label),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: isHighlighted
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.surfaceVariant,
    );
  }
}
