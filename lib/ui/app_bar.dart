import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  const MyAppBar(
      {Key? key,
      required this.title,
      required this.isSelected,
      this.onDelete,
      this.onCancel})
      : super(key: key);

  final String title;
  final bool isSelected;
  final Function()? onDelete;
  final Function()? onCancel;

  @override
  State<MyAppBar> createState() => _MyAppBar();
}

class _MyAppBar extends State<MyAppBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: AppBar(
          leading: widget.isSelected
              ? IconButton(
                  icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: AnimationController(vsync: this)),
                  onPressed: () => widget.onCancel?.call(),
                )
              : null,
          title: Text(widget.title),
          actions: [
            widget.isSelected
                ? IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () => widget.onDelete?.call(),
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
}
