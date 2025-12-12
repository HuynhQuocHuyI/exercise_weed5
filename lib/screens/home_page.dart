import 'package:flutter/material.dart';
import '../models/note.dart';
import '../widgets/note_card.dart';
import '../widgets/view_empty_note.dart';

class HomeScreen extends StatefulWidget {
  final List<Note> note;
  const HomeScreen({super.key, this.note = const []});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Note> list = [];
    for (var i = 0; i < widget.note.length; i++) {
      if (!widget.note[i].isCompleted) {
        list.add(widget.note[i]);
      }
    }

    if (list.length > 0) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisExtent: 252,
            mainAxisSpacing: 10,
          ),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return CardNoteWidget(note: list[index]);
          },
        ),
      );
    } else {
      return const ViewEmptyNote();
    }
  }
}
