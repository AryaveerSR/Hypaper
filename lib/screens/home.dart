import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../helpers/home.dart';
import '../ui/note_card.dart';
import '../ui/app_bar.dart';
import '../services/notes.dart';
import '../ui/drawer.dart';
import '../ui/sort_dropdown.dart';
import '../ui/delete.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<Note> _notes = [];
  List<int> selectedNotes = [];
  SortType sortValue = SortType.dateCreated;

  final HomeHelper homeHelper = HomeHelper(GetIt.I.get());

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async => homeHelper
      .getNotes(sortValue)
      .then((notes) => setState(() => _notes = notes));

  void _deleteNote(Note note) {
    showDialog(
        context: context,
        builder: (context) => DeleteDialog(
              deleteMultiple: false,
              onDelete: () async {
                if (selectedNotes.contains(note.id)) {
                  setState(() => selectedNotes.remove(note.id));
                }
                homeHelper.deleteNote(context, note).then((_) => _loadNotes());
              },
            ));
  }

  void _deleteBulk() {
    showDialog(
        context: context,
        builder: (context) => DeleteDialog(
              deleteMultiple: true,
              onDelete: () async {
                homeHelper
                    .deleteBulk(context, selectedNotes)
                    .then((_) => _loadNotes());
                setState(() => selectedNotes = []);
              },
            ));
  }

  _selectNote(Note note) {
    setState(() {
      selectedNotes.contains(note.id)
          ? selectedNotes.remove(note.id)
          : selectedNotes.add(note.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadNotes();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: MyAppBar(
          title: "Hypaper",
          isSelected: selectedNotes.isNotEmpty,
          onCancel: () => setState(() => selectedNotes = []),
          onDelete: _deleteBulk),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
          onPressed: () => homeHelper.createNote(context),
          child: const Icon(Icons.add)),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SortDropdown(
                        value: sortValue,
                        onChanged: (value) =>
                            setState(() => sortValue = value))),
                ...(_notes
                    .map((note) => NoteCard(
                        displayNote: note,
                        clearance: 12,
                        isSelected: selectedNotes.contains(note.id),
                        onDelete: () => _deleteNote(note),
                        onSelect: () => _selectNote(note),
                        onTap: () => selectedNotes.isEmpty
                            ? homeHelper.openViewer(context, note)
                            : _selectNote(note)))
                    .toList()),
                const SizedBox(height: 80)
              ]),
        ),
      ),
    );
  }
}
