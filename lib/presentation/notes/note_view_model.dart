import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:flutter_note_app/presentation/notes/note_event.dart';
import 'package:flutter_note_app/presentation/notes/notes_state.dart';

class NoteViewModel with ChangeNotifier {
  NoteRepository repository;

  NotesState _state = const NotesState(notes: []);
  NotesState get state => _state;

  Note? _recentlyDeleteNote;

  NoteViewModel(this.repository) {
    _loadNotes();
  }

  void onEvent(NoteEvent event) {
    event.when(
        loadNotes: _loadNotes,
        deleteNote: _deleteNote,
        restoreNote: _restoreNote);
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await repository.getNotes();
    _state = state.copyWith(notes: notes);
    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await repository.deleteNote(note);

    _recentlyDeleteNote = note;

    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeleteNote != null) {
      await repository.insertNote(_recentlyDeleteNote!);

      _recentlyDeleteNote = null;

      _loadNotes();
    }
  }
}
