import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/use_case/use_cases.dart';
import 'package:flutter_note_app/domain/util/note_order.dart';
import 'package:flutter_note_app/domain/util/order_type.dart';
import 'package:flutter_note_app/presentation/notes/note_event.dart';
import 'package:flutter_note_app/presentation/notes/notes_state.dart';

class NoteViewModel with ChangeNotifier {
  final UseCases useCases;
  NotesState _state = const NotesState(
      notes: [], noteOrder: NoteOrder.date(OrderType.descending()));
  NotesState get state => _state;

  Note? _recentlyDeleteNote;

  NoteViewModel(this.useCases) {
    _loadNotes();
  }

  void onEvent(NoteEvent event) {
    event.when(
      loadNotes: _loadNotes,
      deleteNote: _deleteNote,
      restoreNote: _restoreNote,
      changeOrder: (NoteOrder noteOrder) {
        _state = state.copyWith(noteOrder: noteOrder);
        _loadNotes();
      },
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await useCases.getNotes(state.noteOrder);
    _state = state.copyWith(notes: notes);
    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await useCases.deleteNote(note);

    _recentlyDeleteNote = note;

    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    if (_recentlyDeleteNote != null) {
      await useCases.addNote(_recentlyDeleteNote!);

      _recentlyDeleteNote = null;

      _loadNotes();
    }
  }
}
