// widgets/note_popup.dart
import 'package:flutter/material.dart';

void showNotePopup(BuildContext context, String noteContent) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('오늘의 응원'),
      content: Text(noteContent),
      actions: [
        TextButton(
          child: Text('닫기'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}
