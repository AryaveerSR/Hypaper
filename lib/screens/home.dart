import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hypaper/screens/editor.dart';
import 'package:hypaper/screens/viewer.dart';
import 'package:hypaper/ui/note_card.dart';

import '../ui/app_bar/app_bar.dart';
import '../services/notes/notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final NotesRepository _notesRepository = GetIt.I.get();
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  _loadNotes() async {
    final notes = await _notesRepository.getAllNotes();
    setState(() => _notes = notes);
  }

  _addNote() async {
    final newNote = Note(
        title: "Untitled Note",
        content: "This is an untitled note. You can edit it here.",
        dateCreated: DateTime.now(),
        dateEdited: DateTime.now());

    final newID = await _notesRepository.addNote(newNote);
    _editNote(
        Note(
            id: newID,
            title: "Untitled Note",
            content: "This is an untitled note. You can edit it here.",
            dateCreated: DateTime.now(),
            dateEdited: DateTime.now()),
        isNew: true);
  }

  _deleteNote(Note note) async {
    await _notesRepository.deleteNote(note.id!);
    _loadNotes();
  }

  _viewNote(Note note) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ViewerScreen(
              updateNote: () async =>
                  await _notesRepository.getNote(note.id!))));

  _editNote(Note note, {bool isNew = false}) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditorScreen(note: note, isNew: isNew)));

  @override
  Widget build(BuildContext context) {
    _loadNotes();
    return Scaffold(
      appBar: const MyAppBar(
        title: "Hypaper",
      ),
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: (_notes
                    .map((note) => NoteCard(
                          displayNote: note,
                          onDelete: () => _deleteNote(note),
                          onTap: () => _viewNote(note),
                          onEdit: () => _editNote(note),
                        ))
                    .toList())),
          )),
    );
  }
}
