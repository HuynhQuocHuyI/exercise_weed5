import 'package:exercise_week5/models/note.dart';
import 'package:exercise_week5/screens/note_editor_screen.dart';
import 'package:flutter/material.dart';

class CardNoteWidget extends StatefulWidget {
  final Note note;
  const CardNoteWidget({super.key, required this.note});

  @override
  State<CardNoteWidget> createState() => _CardNoteWidgetState();
}

class _CardNoteWidgetState extends State<CardNoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Color(0xffE3F2FD),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNoteScreen(note: widget.note),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.note.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff1565C0),
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: Text(
                  widget.note.content,
                  maxLines: 8,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 14, color: Color(0xff424242)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
