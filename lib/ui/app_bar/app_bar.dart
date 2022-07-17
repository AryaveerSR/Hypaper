import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: AppBar(
          elevation: 1,
          title: const Text("Hello"),
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
