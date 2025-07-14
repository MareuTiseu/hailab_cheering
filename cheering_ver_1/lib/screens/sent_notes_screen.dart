// screens/sent_notes_screen.dart
import 'package:flutter/material.dart';

class SentNotesScreen extends StatelessWidget {
  // 더미 데이터
  final List<String> sentNotes = [
    '누군가에게 전한 응원 메시지입니다.',
    '당신의 하루가 빛나길 바라는 마음으로 썼어요.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('작성한 쪽지')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: sentNotes.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) =>
            ListTile(title: Text(sentNotes[index])),
      ),
    );
  }
}
