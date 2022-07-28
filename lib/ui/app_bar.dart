import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? isSelected;
  final Function()? onDelete;
  final Function()? onCancel;

  const MyAppBar(
      {Key? key,
      required this.title,
      this.isSelected,
      this.onDelete,
      this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: AppBar(
          leading: isSelected!
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: onCancel,
                )
              : null,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
          elevation: 1,
          title: Text(title, style: Theme.of(context).textTheme.headline6),
          actions: [
            isSelected!
                ? IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: onDelete,
                  )
                : IconButton(
                    icon: Theme.of(context).brightness == Brightness.dark
                        ? const Icon(CupertinoIcons.brightness,
                            color: Colors.white)
                        : const Icon(CupertinoIcons.moon, color: Colors.black),
                    onPressed: () =>
                        ThemeProvider.controllerOf(context).nextTheme(),
                  ),
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
