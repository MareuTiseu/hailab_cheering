// lib/services/notification_history_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/notification_model.dart';

class NotificationHistoryService {
  static final NotificationHistoryService _instance = NotificationHistoryService._internal();
  factory NotificationHistoryService() => _instance;
  NotificationHistoryService._internal();

  static const String _key = 'notification_history';
  List<NotificationModel> _notifications = [];

  // 알림 내역 로드
  Future<void> loadNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? data = prefs.getString(_key);

      if (data != null) {
        final List<dynamic> jsonList = jsonDecode(data);
        _notifications = jsonList.map((json) => NotificationModel.fromJson(json)).toList();
      }
    } catch (e) {
      print('알림 내역 로드 실패: $e');
      _notifications = [];
    }
  }

  // 알림 내역 저장
  Future<void> saveNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String data = jsonEncode(_notifications.map((n) => n.toJson()).toList());
      await prefs.setString(_key, data);
    } catch (e) {
      print('알림 내역 저장 실패: $e');
    }
  }

  // 새 알림 추가
  Future<void> addNotification({
    required String title,
    required String body,
    required String type,
    String? targetScreen,
  }) async {
    final notification = NotificationModel(
      id: 'notif_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      body: body,
      createdTime: DateTime.now(),
      type: type,
      targetScreen: targetScreen,
    );

    _notifications.insert(0, notification); // 최신 알림을 맨 앞에
    await saveNotifications();
  }

  // 알림 읽음 처리
  Future<void> markAsRead(String id) async {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      await saveNotifications();
    }
  }

  // 안 읽은 알림 가져오기
  List<NotificationModel> getUnreadNotifications() {
    return _notifications.where((n) => !n.isRead).toList();
  }

  // 읽은 알림 가져오기
  List<NotificationModel> getReadNotifications() {
    return _notifications.where((n) => n.isRead).toList();
  }

  // 모든 알림 가져오기 (최신순)
  List<NotificationModel> getAllNotifications() {
    return List.from(_notifications);
  }

  // 안 읽은 알림 개수
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  // 알림 내역 초기화
  Future<void> clearHistory() async {
    _notifications.clear();
    await saveNotifications();
  }

  // 작성 독려 알림 추가
  Future<void> addWriteReminderNotification() async {
    await addNotification(
      title: '🌟 응원 쪽지 작성 시간이에요!',
      body: '동료들에게 따뜻한 응원 메시지를 전해보세요.',
      type: 'write_reminder',
      targetScreen: 'writing',
    );
  }

  // 메시지 수신 알림 추가
  Future<void> addMessageReceivedNotification() async {
    await addNotification(
      title: '💌 동료들이 보낸 응원 메시지가 도착했어요!',
      body: '새로운 응원 메시지를 확인해보세요!',
      type: 'message_received',
      targetScreen: 'received',
    );
  }
}
