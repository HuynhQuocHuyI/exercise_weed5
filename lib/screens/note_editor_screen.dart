import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';

class CreateNoteScreen extends StatefulWidget {
  final Note? note;
  const CreateNoteScreen({super.key, this.note});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();

  Future<void> save_note(BuildContext dialogContext) async {
    try {
      if (title.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tiêu đề không được để trống!')),
        );
        return;
      }
      
      Note? c_note;
      final provider = Provider.of<Noteprovider>(context, listen: false);
      if (widget.note == null) {
        c_note = Note(
          title: title.text,
          content: content.text,
          create_at: DateTime.now(),
          update_at: DateTime.now(),
          isCompleted: false,
        );
        await provider.addNotes(c_note);
      } else {
        c_note = Note(
          id: widget.note!.id,
          title: title.text,
          content: content.text,
          create_at: widget.note!.create_at,
          update_at: DateTime.now(),
          isCompleted: widget.note!.isCompleted,
        );
        await provider.uppdateNotes(c_note);
      }
      Navigator.of(dialogContext).pop();
      Navigator.of(context).pop();
    } catch (e) {
      print('loi database: $e');
    }
  }

  Future<void> delete_note(BuildContext dialogContext) async {
    try {
      final provider = Provider.of<Noteprovider>(context, listen: false);
      if (widget.note != null) {
        await provider.deleteNotes(widget.note!);
      }

      Navigator.of(context).pop();
    } catch (e) {
      print('loi database: ${e}');
    } finally {
      Navigator.of(dialogContext).pop();
    }
  }

  Future<void> _showDeleteDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Bạn Có Chắc Muốn Xóa Ghi Chú Này Chứ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('Ghi chú sẽ được xóa vĩnh viễn!')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Xóa'),
              onPressed: () {
                delete_note(dialogContext);
              },
            ),
            SizedBox(height: 20),

            TextButton(
              child: const Text('Quay lại'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showTitleDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Nhập Tiêu Đề'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Điền tiêu đề cho ghi chú.'),
                TextField(
                  controller: title,
                  decoration: const InputDecoration(
                    hintText: 'Bắt đầu điền tiêu đề của bạn...',
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('lưu'),
              onPressed: () {
                save_note(dialogContext);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      title.text = widget.note!.title;
      content.text = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTitleDialog();
        },
        child: Icon(Icons.save_alt, color: Colors.black),
      ),

      appBar: AppBar(
        title: Text(
          widget.note == null ? "Tạo Một Ghi Chú Mới!" : widget.note!.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        actions: [
          if (widget.note != null)
            IconButton(
              onPressed: () {
                _showDeleteDialog();
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
              controller: content,
              decoration: const InputDecoration(
                hintText: 'Bắt đầu ghi chú của bạn...',
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 18),

              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }
}
