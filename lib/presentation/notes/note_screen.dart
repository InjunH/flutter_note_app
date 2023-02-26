import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_note_app/domain/model/note.dart';
import 'package:flutter_note_app/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:flutter_note_app/ui/colors.dart';

import 'components/note_item.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          children: [
            NoteItem(
              onDeleteTap: () {},
              note: Note(
                  title: 'title 1',
                  content: 'content 1',
                  color: wisteria.value,
                  timeStamp: 1),
            ),
            NoteItem(
              onDeleteTap: () {},
              note: Note(
                  title: 'title 2',
                  content: 'content 2',
                  color: skyBlue.value,
                  timeStamp: 2),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) => const AddEditNoteScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
