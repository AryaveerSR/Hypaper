import 'package:flutter/cupertino.dart';
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
          elevation: 1,
          title: Text(title, style: Theme.of(context).textTheme.headline6),
          actions: [
            IconButton(
              icon: Theme.of(context).brightness == Brightness.dark
                  ? const Icon(CupertinoIcons.brightness, color: Colors.white)
                  : const Icon(CupertinoIcons.moon, color: Colors.black),
              onPressed: () => ThemeProvider.controllerOf(context).nextTheme(),
            ),
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
