import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'editor.dart';
import 'viewer.dart';
import '../ui/note_card.dart';
import '../ui/app_bar/app_bar.dart';
import '../services/notes/notes.dart';
import '../ui/drawer/drawer.dart';
import '../ui/bottom_navigation/bottom_navigation.dart';

enum SortBy { dateCreated, dateEdited }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final NotesRepository _notesRepository = GetIt.I.get();
  List<Note> _notes = [];
  List<Note> selectedNotes = [];
  SortBy sortValue = SortBy.dateCreated;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  _loadNotes() async {
    final notes = await _notesRepository.getAllNotes();
    notes.sort((a, b) {
      if (sortValue == SortBy.dateCreated) {
        return a.dateCreated.compareTo(b.dateCreated);
      } else {
        return a.dateEdited.compareTo(b.dateEdited);
      }
    });

    setState(() => _notes = notes.reversed.toList());
  }

  _selectNote(Note note) {
    setState(() {
      if (selectedNotes.contains(note)) {
        selectedNotes.remove(note);
      } else {
        selectedNotes.add(note);
      }
    });
    print(selectedNotes.toString());
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

  _repoDeleteNote(Note note) async {
    await _notesRepository.deleteNote(note.id!);
    _loadNotes();
  }

  _deleteNote(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
            onPressed: () {
              _repoDeleteNote(note);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
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
      drawer: const AppDrawer(),
      bottomNavigationBar: BottomNavigation(
        showDelete: selectedNotes.isNotEmpty,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Text(
                          "Sort By",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      DropdownButton(
                        style: Theme.of(context).textTheme.bodyMedium,
                        elevation: 0,
                        onChanged: (_) {},
                        value: sortValue == SortBy.dateCreated
                            ? "Date Created"
                            : "Date Edited",
                        items: [
                          DropdownMenuItem(
                            value: "Date Created",
                            child: Text(
                              "Date Created",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            onTap: () => {
                              setState(() {
                                sortValue = SortBy.dateCreated;
                              })
                            },
                          ),
                          DropdownMenuItem(
                            value: "Date Edited",
                            child: Text(
                              "Date Edited",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            onTap: () => {
                              setState(() {
                                sortValue = SortBy.dateEdited;
                              })
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  ...(_notes
                      .map((note) => NoteCard(
                            displayNote: note,
                            onDelete: () => _deleteNote(note),
                            onTap: () => _viewNote(note),
                            onEdit: () => _editNote(note),
                            onSelect: () => _selectNote(note),
                          ))
                      .toList())
                ]),
          )),
    );
  }
}
