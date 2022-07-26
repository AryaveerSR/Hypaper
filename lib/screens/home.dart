import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hypaper/ui/dialogs/delete.dart';
import 'package:hypaper/ui/dialogs/notify.dart';

import 'editor.dart';
import 'viewer.dart';
import '../ui/note_card.dart';
import '../ui/app_bar.dart';
import '../services/notes/notes.dart';
import '../ui/drawer.dart';
import '../ui/sort_dropdown.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final NotesRepository _notesRepository = GetIt.I.get();
  List<Note> _notes = [];
  List<int> selectedNotes = [];
  SortType sortValue = SortType.dateCreated;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  _loadNotes() async {
    final notes = await _notesRepository.getAllNotes();
    notes.sort((a, b) => sortValue == SortType.dateCreated
        ? a.dateCreated.compareTo(b.dateCreated)
        : a.dateEdited.compareTo(b.dateEdited));

    setState(() => _notes = notes.reversed.toList());
  }

  _addNote() async {
    final newNote = await _notesRepository.createNote();
    _editNote(newNote);
  }

  _deleteNote(Note note) {
    showDialog(
        context: context,
        builder: (context) => DeleteDialog(
              onDelete: () async {
                notifySnack(context, type: NotifyType.deleted);
                await _notesRepository.deleteNote(note.id!);
                _loadNotes();
              },
              deleteType: DeleteType.single,
            ));
  }

  _selectNote(Note note) {
    selectedNotes.contains(note.id)
        ? selectedNotes.remove(note.id)
        : selectedNotes.add(note.id!);
  }

  _viewNote(Note note) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ViewerScreen(
              updateNote: () async =>
                  await _notesRepository.getNote(note.id!))));

  _editNote(Note note) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditorScreen(note: note, isNew: true)));

  @override
  Widget build(BuildContext context) {
    _loadNotes();
    return Scaffold(
      appBar: MyAppBar(
        title: "Hypaper",
        isSelected: selectedNotes.isNotEmpty,
        onCancel: () {
          setState(() => selectedNotes = []);
        },
        onDelete: () {
          showDialog(
              context: context,
              builder: (context) => DeleteDialog(
                    onDelete: () async {
                      notifySnack(context, type: NotifyType.deleted);
                      await _notesRepository.deleteNotes(selectedNotes);
                      setState(() => selectedNotes = []);
                      _loadNotes();
                    },
                    deleteType: DeleteType.all,
                  ));
        },
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
          onPressed: _addNote,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add)),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SortDropdown(
                      value: sortValue,
                      onChanged: (value) => setState(() => sortValue = value)),
                  ...(_notes
                      .map((note) => NoteCard(
                            displayNote: note,
                            isSelected: selectedNotes.contains(note.id),
                            onDelete: () => _deleteNote(note),
                            onTap: () {
                              selectedNotes.isEmpty
                                  ? _viewNote(note)
                                  : _selectNote(note);
                            },
                            onSelect: () => _selectNote(note),
                          ))
                      .toList())
                ]),
          )),
    );
  }
}
