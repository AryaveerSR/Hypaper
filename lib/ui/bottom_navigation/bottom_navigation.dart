import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BottomNavigation extends StatelessWidget {
  final Function()? onDeleteAll;
  final bool showDelete;
  const BottomNavigation({Key? key, this.onDeleteAll, required this.showDelete})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // bottom navigation
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(showDelete ? Icons.delete : Icons.check_box),
          label: showDelete ? 'Delete All' : 'Select All',
        ),
      ],
    );
  }
}
