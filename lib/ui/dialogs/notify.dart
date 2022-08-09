import 'package:flutter/material.dart';

enum NotifyType { updated, deleted }

void notifySnack(BuildContext context, {required NotifyType type}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content:
          Text('Note ${type == NotifyType.updated ? 'Updated' : 'Deleted'}'),
      action: SnackBarAction(
          textColor: Theme.of(context).colorScheme.onPrimary,
          label: 'OK',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()),
      duration: const Duration(seconds: 2)));
}
