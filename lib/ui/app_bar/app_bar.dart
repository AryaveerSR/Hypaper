import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: AppBar(
          leading: title == "Notes"
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null,
          elevation: 1,
          title: Text(title),
          actions: [
            IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.dark
                  ? Icons.sunny
                  : Icons.brightness_2_rounded),
              onPressed: () => ThemeProvider.controllerOf(context).nextTheme(),
            ),
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
