import 'package:flutter/material.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:flutter_note_app/presentation/notes/note_event.dart';
import 'package:flutter_note_app/presentation/notes/note_view_model.dart';
import 'package:provider/provider.dart';

import 'components/note_item.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NoteViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Notes',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.sort))],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: state.notes
              .map((note) => GestureDetector(
                    onTap: () async {
                      bool? isSaved = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) =>
                                  AddEditNoteScreen(note: note)));

                      if (isSaved != null && isSaved) {
                        viewModel.onEvent(const NoteEvent.loadNotes());
                      }
                    },
                    child: NoteItem(
                      onDeleteTap: () {
                        viewModel.onEvent(NoteEvent.deleteNote(note));

                        final snackBar = SnackBar(
                          content: const Text('노트가 삭제되었습니다.'),
                          action: SnackBarAction(
                            label: '취소',
                            onPressed: () {
                              viewModel.onEvent(NoteEvent.restoreNote());
                            },
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      note: note,
                    ),
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? isSaved = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) => const AddEditNoteScreen()));

          if (isSaved != null && isSaved) {
            viewModel.onEvent(const NoteEvent.loadNotes());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
