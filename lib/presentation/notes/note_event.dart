import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/note.dart';

part 'note_event.freezed.dart';

@freezed
class NoteEvent<T> with _$NoteEvent<T> {
  const factory NoteEvent.loadNotes() = LoadNote;
  const factory NoteEvent.deleteNote(Note note) = DeleteNote;
  const factory NoteEvent.restoreNote() = ReStoreNote;
}