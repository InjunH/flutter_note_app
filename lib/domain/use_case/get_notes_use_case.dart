import 'package:flutter_note_app/domain/repository/note_repository.dart';

import '../model/note.dart';

class GetNotesUseCase {
  final NoteRepository repository;

  GetNotesUseCase(this.repository);

  Future<List<Note>> call() async {
    List<Note> notes = await repository.getNotes();
    notes.sort(((a, b) => -a.timeStamp.compareTo(b.timeStamp)));
    return notes;
  }
}
