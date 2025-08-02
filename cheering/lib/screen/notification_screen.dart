// lib/screen/notification_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/notification_model.dart';
import '../services/notification_history_service.dart';
import 'writing_screen.dart';
import 'received_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  final NotificationHistoryService _historyService = NotificationHistoryService();
  late TabController _tabController;

  List<NotificationModel> _unreadNotifications = [];
  List<NotificationModel> _readNotifications = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadNotifications();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadNotifications() async {
    await _historyService.loadNotifications();
    setState(() {
      _unreadNotifications = _historyService.getUnreadNotifications();
      _readNotifications = _historyService.getReadNotifications();
    });
  }

  Future<void> _onNotificationTap(NotificationModel notification) async {
    // 알림을 읽음 처리
    await _historyService.markAsRead(notification.id);

    // 해당 화면으로 이동
    if (notification.targetScreen == 'writing') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => WritingScreen()),
      );
    } else if (notification.targetScreen == 'received') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ReceivedScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text(
          '알림',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadNotifications,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black87,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Color(0xFF2D61AC),
          tabs: [
            Tab(text: '안 읽은 알림 (${_unreadNotifications.length})'),
            Tab(text: '받은 알림 목록 (${_readNotifications.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationList(_unreadNotifications, '새로운 알림이 없습니다.', isUnread: true),
          _buildNotificationList(_readNotifications, '받은 알림이 없습니다.', isUnread: false),
        ],
      ),
    );
  }

  Widget _buildNotificationList(List<NotificationModel> notifications, String emptyMessage, {required bool isUnread}) {
    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isUnread ? Icons.notifications_none : Icons.notifications,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              emptyMessage,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadNotifications,
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _buildNotificationCard(notification, isUnread: isUnread);
        },
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel notification, {required bool isUnread}) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: isUnread ? 3 : 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: isUnread ? () => _onNotificationTap(notification) : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isUnread ? Colors.blue.shade300 : Colors.grey.shade300,
              width: isUnread ? 2 : 1,
            ),
            color: isUnread ? Colors.blue.shade50 : Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상태 표시
              Row(
                children: [
                  Icon(
                    notification.isWriteReminder ? Icons.edit : Icons.mail,
                    size: 20,
                    color: notification.isWriteReminder ? Colors.orange.shade600 : Colors.green.shade600,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      notification.isWriteReminder ? '작성 독려' : '메시지 수신',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: notification.isWriteReminder ? Colors.orange.shade600 : Colors.green.shade600,
                      ),
                    ),
                  ),
                  if (isUnread)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'NEW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (kIsWeb)
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'WEB',
                        style: TextStyle(fontSize: 10, color: Colors.orange.shade700),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 12),

              // 제목과 내용
              Text(
                notification.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                notification.body,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 12),

              // 시간 정보
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                  SizedBox(width: 4),
                  Text(
                    _formatDateTime(notification.createdTime),
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  Spacer(),
                  if (isUnread)
                    Row(
                      children: [
                        Icon(Icons.touch_app, size: 16, color: Colors.blue.shade600),
                        SizedBox(width: 4),
                        Text(
                          '탭해서 이동',
                          style: TextStyle(fontSize: 12, color: Colors.blue.shade600),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return '방금 전';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${dateTime.month}/${dateTime.day} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}
