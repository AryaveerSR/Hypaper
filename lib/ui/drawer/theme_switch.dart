import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        fillColor: Theme.of(context).colorScheme.surface,
        highlightColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).primaryColorDark
            : Theme.of(context).primaryColorLight,
        elevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        hoverElevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), side: BorderSide.none),
        constraints: const BoxConstraints(
            maxWidth: 92, maxHeight: 42, minWidth: 92, minHeight: 42),
        onPressed: () => ThemeProvider.controllerOf(context).nextTheme(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.sunny,
                size: 20,
                color: Color(Theme.of(context).brightness == Brightness.light
                    ? 0xFF000000
                    : 0xFF64748b),
              ),
              Icon(Icons.brightness_2_rounded,
                  size: 20,
                  color: Color(Theme.of(context).brightness == Brightness.light
                      ? 0xff64748b
                      : 0xFFFFFFFF))
            ],
          ),
        ));
  }
}
