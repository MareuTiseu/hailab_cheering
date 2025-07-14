// models/note.dart

class Note {
  final String id;
  final String content;
  final DateTime timestamp;
  final bool isSent;

  Note({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.isSent,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
    'isSent': isSent,
  };

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      isSent: json['isSent'],
    );
  }
}
