import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/note.dart';

class Noteprovider extends ChangeNotifier {
  List<Note> _notes = [];
  bool _isLoading = true;
  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;

  Future<void> loadsNotes() async {
    try {
      setLoading(true);
      _notes = await DatabaseHelper.instance.readAll();
    } catch (e) {
      print('loi khi load database: ${e}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> addNotes(Note note) async {
    try {
      setLoading(true);
      await DatabaseHelper.instance.create(note);
      await loadsNotes();
    } catch (e) {
      print('loi khi tao note moi ${e}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> uppdateNotes(Note note) async {
    try {
      setLoading(true);
      await DatabaseHelper.instance.update(note);
      await loadsNotes();
    } catch (e) {
      print('loi khi sua note moi ${e}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteNotes(Note note) async {
    try {
      setLoading(true);
      await DatabaseHelper.instance.delete(note.id);
      await loadsNotes();
    } catch (e) {
      print('loi khi xoa note ${e}');
    } finally {
      setLoading(false);
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
