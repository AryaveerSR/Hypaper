import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'note.model.dart';
export 'note.model.dart';

class NotesRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("notes");

  Future<Note> createNote() async {
    final note = Note(
      title: "Untitled Note",
      content: "This is an untitled note. You can edit it here.",
      dateCreated: DateTime.now(),
      dateEdited: DateTime.now(),
    );
    final id = await _store.add(_database, note.toMap());
    return note.copyWith(id: id);
  }

  Future updateNote(Note note) async =>
      await _store.record(note.id).update(_database, note.toMap());

  Future deleteNote(int noteID) async =>
      await _store.record(noteID).delete(_database);

  Future<Note> getNote(int noteID) async {
    final snapshot = await _store.record(noteID).getSnapshot(_database);
    return Note.fromMap(snapshot!.key, snapshot.value);
  }

  Future<List<Note>> getAllNotes() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => Note.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }
}
