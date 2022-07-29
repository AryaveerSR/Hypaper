import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isSelected;
  final Function()? onDelete;
  final Function()? onCancel;

  const MyAppBar(
      {Key? key,
      required this.title,
      required this.isSelected,
      this.onDelete,
      this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: AppBar(
          leading: isSelected
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onCancel,
                )
              : null,
          elevation: 1,
          title: Text(title),
          actions: [
            isSelected
                ? IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: onDelete,
                  )
                : IconButton(
                    icon: Theme.of(context).brightness == Brightness.dark
                        ? const Icon(CupertinoIcons.brightness)
                        : const Icon(CupertinoIcons.moon),
                    onPressed: () =>
                        ThemeProvider.controllerOf(context).nextTheme(),
                  ),
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
