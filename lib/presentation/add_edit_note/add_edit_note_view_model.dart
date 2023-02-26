import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_ui_event.dart';
import 'package:flutter_note_app/ui/colors.dart';

class AddEditNoteViewModel with ChangeNotifier {
  final NoteRepository repository;

  AddEditNoteViewModel(this.repository);

  int _color = roseBud.value;

  int get color => _color;
/*
  Stream has already been listened to.
  /// broadcast 여러번 listen 을 할 수 있다.
  // final _eventController = StreamController<AddEditNoteUiEvent>.broadcast();
 */
  final _eventController = StreamController<AddEditNoteUiEvent>.broadcast();

  Stream<AddEditNoteUiEvent> get eventStream => _eventController.stream;

  void onEvent(AddEditNoteEvent event) {
    event.when(changeColor: _changeColor, saveNote: _saveNote);
  }

  Future<void> _changeColor(int color) async {
    _color = color;
    notifyListeners();
  }

  Future<void> _saveNote(int? id, String title, String content) async {
    if (title.isEmpty || content.isEmpty) {
      _eventController
          .add(const AddEditNoteUiEvent.showSnackBar('제목이나 내용이 비어있습니다.'));
      return;
    }
    if (id == null) {
      await repository.insertNote(Note(
        title: title,
        content: content,
        color: _color,
        timeStamp: DateTime.now().microsecondsSinceEpoch,
      ));
    } else {
      await repository.updateNote(Note(
          id: id,
          title: title,
          content: content,
          color: _color,
          timeStamp: DateTime.now().microsecondsSinceEpoch));
    }

    _eventController.add(const AddEditNoteUiEvent.saveNote());
  }
}
