// services/note_service.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';
import 'package:uuid/uuid.dart';

class NoteService {
  static const _sentKey = 'sent_notes';
  static const _receivedKey = 'received_notes';

  Future<void> saveSentNote(String message) async {
    final prefs = await SharedPreferences.getInstance();
    final notes = await getSentNotes();

    final newNote = Note(
      id: Uuid().v4(),
      content: message,
      timestamp: DateTime.now(),
      isSent: true,
    );

    notes.add(newNote);
    final encoded = notes.map((n) => jsonEncode(n.toJson())).toList();
    await prefs.setStringList(_sentKey, encoded);
  }

  Future<List<Note>> getSentNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_sentKey) ?? [];
    return rawList
        .map((jsonStr) => Note.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  Future<void> saveReceivedNote(String message) async {
    final prefs = await SharedPreferences.getInstance();
    final notes = await getReceivedNotes();

    final newNote = Note(
      id: Uuid().v4(),
      content: message,
      timestamp: DateTime.now(),
      isSent: false,
    );

    notes.add(newNote);
    final encoded = notes.map((n) => jsonEncode(n.toJson())).toList();
    await prefs.setStringList(_receivedKey, encoded);
  }

  Future<List<Note>> getReceivedNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(_receivedKey) ?? [];
    return rawList
        .map((jsonStr) => Note.fromJson(jsonDecode(jsonStr)))
        .toList();
  }
}
