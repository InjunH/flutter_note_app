import 'package:flutter_note_app/domain/repository/note_repository.dart';

import '../model/note.dart';

class UpdateUseCaseNote {
  final NoteRepository repository;

  UpdateUseCaseNote(this.repository);

  Future<void> call(Note note) async {
    await repository.updateNote(note);
  }
}
