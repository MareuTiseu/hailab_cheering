// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'compose_screen.dart';
import 'received_notes_screen.dart';
import 'sent_notes_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('응원 쪽지 앱')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ComposeScreen()),
              ),
              child: Text('작성하기'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ReceivedNotesScreen()),
              ),
              child: Text('받은 쪽지'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SentNotesScreen()),
              ),
              child: Text('작성한 쪽지'),
            ),
          ],
        ),
      ),
    );
  }
}
