import 'package:flutter/material.dart';

import '../screens/editor.dart';
import '../screens/viewer.dart';
import '../services/notes.dart';
import '../ui/dialogs/notify.dart';
import '../ui/sort_dropdown.dart';

class HomeHelper {
  final NotesRepository notesRepository;
  HomeHelper(this.notesRepository);

  Future<List<Note>> getNotes(SortType type) async {
    final notes = await notesRepository.getAllNotes();
    notes.sort((a, b) => type == SortType.dateCreated
        ? a.dateCreated.compareTo(b.dateCreated)
        : a.dateEdited.compareTo(b.dateEdited));

    return notes.reversed.toList();
  }

  Future<void> createNote(BuildContext context) async {
    final note = await notesRepository.createNote();
    (() => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditorScreen(note: note, isNew: true))))();
  }

  Future<void> deleteNote(BuildContext context, Note note) async {
    notifySnack(context, type: NotifyType.deleted);
    await notesRepository.deleteNote(note.id!);
  }

  Future<void> deleteBulk(BuildContext context, List<int> noteIDs) async {
    notifySnack(context, type: NotifyType.deleted);
    await notesRepository.deleteNotes(noteIDs);
  }

  void openViewer(BuildContext context, Note note) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ViewerScreen(
              updateNote: () async =>
                  await notesRepository.getNote(note.id!))));
}
