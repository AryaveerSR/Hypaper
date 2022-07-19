import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../services/notes/notes.dart';
import '../ui/app_bar/app_bar.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({Key? key}) : super(key: key);
  @override
  State<EditorScreen> createState() => _EditorScreen();
}

class _EditorScreen extends State<EditorScreen> {
  final NotesRepository _notesRepository = GetIt.I.get();
  Note? note;

  void _editNote() async {
    Navigator.of(context).pop();
    await _notesRepository.updateNote(note!);
  }

  @override
  Widget build(BuildContext context) {
    note = ModalRoute.of(context)!.settings.arguments as Note;

    return Scaffold(
      appBar: const MyAppBar(
        title: "Edit Note",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _editNote,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.save),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
