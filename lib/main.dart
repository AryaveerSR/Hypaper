import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import 'screens/home.dart';
import 'screens/splash.dart';
import 'services/init.dart';
import 'services/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _App();
}

class _App extends State<App> {
  final Future _initFuture = Init.initialize();

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        themes: [lightTheme, darkTheme],
        saveThemesOnChange: true,
        defaultThemeId: "dark",
        loadThemeOnInit: true,
        child: ThemeConsumer(
            child: Builder(
                builder: (themeContext) => MaterialApp(
                      title: 'Hypaper',
                      theme: ThemeProvider.themeOf(themeContext).data,
                      home: FutureBuilder(
                        future: _initFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return const HomeScreen();
                          } else {
                            return const SplashScreen();
                          }
                        },
                      ),
                    ))));
  }
}
