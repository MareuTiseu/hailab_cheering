// screens/review_screen.dart
import 'package:flutter/material.dart';
import 'home_screen.dart';

class ReviewScreen extends StatelessWidget {
  final String originalMessage;

  const ReviewScreen({required this.originalMessage});

  @override
  Widget build(BuildContext context) {
    // GPT 교정된 메시지 placeholder
    final String correctedMessage = ""; // 추후 GPT API 결과로 대체

    return Scaffold(
      appBar: AppBar(title: Text('돌아보기')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('원본 메시지', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(originalMessage),
            SizedBox(height: 24),
            Text('교정된 메시지', style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              height: 100,
              color: Colors.grey[200],
              child: Center(
                child: Text(
                  correctedMessage.isEmpty ? '교정 결과 없음' : correctedMessage,
                ),
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: 저장 및 전송 로직
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text('보내기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
