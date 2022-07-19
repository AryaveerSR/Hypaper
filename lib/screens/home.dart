import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
        content:
            "This is an untitled note. You can edit it by clicking on the pencil icon.",
        dateCreated: DateTime.now(),
        dateEdited: DateTime.now());

    await _notesRepository.addNote(newNote);
    _loadNotes();
  }

  _deleteNote(Note note) async {
    await _notesRepository.deleteNote(note.id!);
    _loadNotes();
  }

  _viewNote(Note note) {
    Navigator.of(context).pushNamed('/notes', arguments: note);
  }

  _editNote(Note note) {
    Navigator.of(context).pushNamed('/edit', arguments: note);
  }

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(8.0),
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
