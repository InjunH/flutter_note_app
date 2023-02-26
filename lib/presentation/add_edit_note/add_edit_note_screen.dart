import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_note_app/ui/colors.dart';

class AddEditNoteScreen extends StatefulWidget {
  const AddEditNoteScreen({super.key});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final List<Color> noteColor = [
    roseBud,
    primrose,
    wisteria,
    skyBlue,
    illusion
  ];

  Color _color = roseBud;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(16),
        color: _color,
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: noteColor
                  .map((color) => InkWell(
                      onTap: () {
                        setState(() {
                          _color = color;
                        });
                      },
                      child: _buildBackGroundColor(
                          color: color, selected: _color == color)))
                  .toList(),
            ),
            TextField(
              controller: _titleController,
              maxLines: 1,
              decoration: const InputDecoration(
                  hintText: '제목을 입력하세요', border: InputBorder.none),
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: darkGray),
            ),
            TextField(
              controller: _contentController,
              maxLength: null,
              decoration: const InputDecoration(
                  hintText: '내용을 입력하세요', border: InputBorder.none),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: darkGray),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildBackGroundColor({required Color color, required bool selected}) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: selected
              ? Border.all(
                  color: Colors.black,
                  width: 2.0,
                )
              : null,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                spreadRadius: 1)
          ]),
    );
  }
}
