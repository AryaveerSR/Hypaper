import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../ui/app_bar/app_bar.dart';
import '../services/notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  NotesRepository _notesRepository = GetIt.I.get();
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
        title: "Hi",
        content: "Hello World",
        dateCreated: DateTime.now(),
        dateEdited: DateTime.now());

    await _notesRepository.addNote(newNote);
    _loadNotes();
  }

  _deleteNote(Note note) async {
    await _notesRepository.deleteNote(note.id!);
    _loadNotes();
  }

  _editNote(Note note) async {
    await _notesRepository.updateNote(note);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[],
      ),
    );
  }
}
