import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Column(
              children: [
                Text(
                  "Hypaper",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(
                          Theme.of(context).brightness == Brightness.dark
                              ? 0xFFFFFFFF
                              : 0xff0f172a)),
                ),
                const SizedBox(height: 16),
                const SizedBox(width: 128, child: LinearProgressIndicator())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
