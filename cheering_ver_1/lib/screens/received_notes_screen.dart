// screens/received_notes_screen.dart
import 'package:flutter/material.dart';

class ReceivedNotesScreen extends StatelessWidget {
  // 더미 데이터
  final List<String> receivedNotes = ['오늘도 잘 하고 있어요!', '힘들면 쉬어가도 괜찮아요.'];

  ReceivedNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('받은 쪽지')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: receivedNotes.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) =>
            ListTile(title: Text(receivedNotes[index])),
      ),
    );
  }
}
