import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  String route;
  IconData icon;
  DrawerItem(this.title, this.icon, this.route);
}

final List<DrawerItem> DrawerItems = [
  DrawerItem("Home", Icons.home_rounded, "/"),
  DrawerItem("Notes", Icons.description_rounded, "/"),
  DrawerItem("To-Do", Icons.checklist_rtl_rounded, "/"),
];

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: Text('Hypaper',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24))),
        ...DrawerItems.map((DrawerItem item) => ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            onTap: () => Navigator.pushNamed(context, item.route)))
      ],
    ));
  }
}
