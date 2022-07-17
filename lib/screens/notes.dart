import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../services/notes/notes.dart';
import '../ui/app_bar/app_bar.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);
  @override
  State<NoteScreen> createState() => _NoteScreen();
}

class _NoteScreen extends State<NoteScreen> {
  NotesRepository _notesRepository = GetIt.I.get();
  Note? note;

  void _editNote() async {
    await _notesRepository.updateNote(note!);
  }

  @override
  Widget build(BuildContext context) {
    note = ModalRoute.of(context)!.settings.arguments as Note;

    return Scaffold(
      appBar: const MyAppBar(
        title: "Notes",
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
