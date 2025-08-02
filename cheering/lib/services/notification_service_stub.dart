// lib/services/notification_service_stub.dart
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  Future<void> initialize() async {
    print('NotificationService: Web에서는 알림 기능이 지원되지 않습니다.');
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    print('Web Notification (stub): $title - $body');
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    print('Web Scheduled Notification (stub): $title at $scheduledTime');
  }

  Future<void> scheduleDailyReminder() async {
    print('Web Daily Reminder (stub): 매일 알림이 설정되었습니다.');
  }

  Future<void> cancelAllNotifications() async {
    print('Web: 모든 알림이 취소되었습니다.');
  }

  Future<void> cancelNotification(int id) async {
    print('Web: 알림 $id가 취소되었습니다.');
  }
}
