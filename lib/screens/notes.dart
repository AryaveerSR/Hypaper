import 'package:flutter/material.dart';
import '../services/notes/notes.dart';
import '../ui/app_bar/app_bar.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);
  @override
  State<NoteScreen> createState() => _NoteScreen();
}

class _NoteScreen extends State<NoteScreen> {
  Note? note;

  void _editNote() {
    Navigator.of(context).pushNamed('/edit', arguments: note);
  }

  @override
  Widget build(BuildContext context) {
    note = ModalRoute.of(context)!.settings.arguments as Note;

    return Scaffold(
      appBar: const MyAppBar(
        title: "View Note",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _editNote,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.edit),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
