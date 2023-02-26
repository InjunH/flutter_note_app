import 'package:flutter_note_app/data/data_source/note_db_helper.dart';
import 'package:flutter_note_app/data/repository/note_repository_impl.dart';
import 'package:flutter_note_app/domain/repository/note_repository.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:flutter_note_app/presentation/notes/note_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite/sqflite.dart';

Future<List<SingleChildWidget>> getProviders() async {
  Database database = await openDatabase('notes_db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER , timeStamp INTEGER)');
  });

  NoteDbHelper noteDbHelper = NoteDbHelper(database);

  NoteRepository repository = NoteRepositoryImpl(noteDbHelper);

  NoteViewModel noteViewModel = NoteViewModel(repository);

  AddEditNoteViewModel addEditNoteViewModel = AddEditNoteViewModel(repository);

  // List<SingleChildWidget> indepentModels = [];

  // List<SingleChildWidget> dependentModels = [];

  // List<SingleChildWidget> viewModels = [];

  // List<SingleChildWidget> globalProviders = [
  //   ...indepentModels,
  //   ...dependentModels,
  //   ...viewModels
  // ];

  // return globalProviders;
  return [
    ChangeNotifierProvider(create: (_) => noteViewModel),
    ChangeNotifierProvider(create: (_) => addEditNoteViewModel),
  ];
}
