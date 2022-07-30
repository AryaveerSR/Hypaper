import 'package:flutter/material.dart';

enum NotifyType { updated, deleted }

void notifySnack(BuildContext context, {required NotifyType type}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
      content: Text(
          'Note ${type == NotifyType.updated ? 'Updated' : 'Deleted'}',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
      duration: const Duration(seconds: 2)));
}
