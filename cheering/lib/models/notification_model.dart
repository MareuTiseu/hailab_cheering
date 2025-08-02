// lib/models/notification_model.dart
class NotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime createdTime;
  final bool isRead;
  final String type; // 'write_reminder', 'message_received'
  final String? targetScreen; // 'writing' or 'received'

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdTime,
    this.isRead = false,
    this.type = 'write_reminder',
    this.targetScreen,
  });

  // JSON 변환 메서드들
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'createdTime': createdTime.toIso8601String(),
      'isRead': isRead,
      'type': type,
      'targetScreen': targetScreen,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      createdTime: DateTime.parse(json['createdTime']),
      isRead: json['isRead'] ?? false,
      type: json['type'] ?? 'write_reminder',
      targetScreen: json['targetScreen'],
    );
  }

  // 복사 메서드
  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    DateTime? createdTime,
    bool? isRead,
    String? type,
    String? targetScreen,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdTime: createdTime ?? this.createdTime,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
      targetScreen: targetScreen ?? this.targetScreen,
    );
  }

  // 편의 메서드
  bool get isWriteReminder => type == 'write_reminder';
  bool get isMessageReceived => type == 'message_received';
}
