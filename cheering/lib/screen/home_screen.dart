// lib/screen/home_screen.dart
import 'package:flutter/material.dart';
import 'writing_screen.dart';
import 'received_screen.dart';
import 'wrote_screen.dart';
import 'notification_screen.dart';
import 'package:flutter/foundation.dart';
import '../services/notification_service_platform.dart';
import '../services/notification_history_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationHistoryService _historyService = NotificationHistoryService();
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _loadNotificationCount();
  }

  Future<void> _loadNotificationCount() async {
    await _historyService.loadNotifications();
    setState(() {
      _unreadCount = _historyService.unreadCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text(
          '    HAILAB 응원쪽지 실험',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_outlined, size: 28),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => NotificationScreen()),
                  );
                  _loadNotificationCount();
                },
              ),
              if (_unreadCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$_unreadCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          // 웹에서만 테스트 버튼 (2가지 알림)
          if (kIsWeb)
            PopupMenuButton<String>(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '테스트',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ),
              onSelected: (value) async {
                if (value == 'write') {
                  await _historyService.addWriteReminderNotification();
                  _loadNotificationCount();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('작성 독려 알림 추가! 🔔'), duration: Duration(seconds: 1)),
                  );
                } else if (value == 'message') {
                  await _historyService.addMessageReceivedNotification();
                  _loadNotificationCount();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('메시지 수신 알림 추가! 💌'), duration: Duration(seconds: 1)),
                  );
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'write',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20, color: Colors.orange),
                      SizedBox(width: 8),
                      Text('작성 독려 알림'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'message',
                  child: Row(
                    children: [
                      Icon(Icons.mail, size: 20, color: Colors.green),
                      SizedBox(width: 8),
                      Text('메시지 수신 알림'),
                    ],
                  ),
                ),
              ],
            ),
          SizedBox(width: 8),
        ],
      ),
      body: Align(
          alignment: Alignment.center,
          child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.9,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 10,
                    child: _buildStyledButton(
                        context,
                        label: '작성하기',
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => WritingScreen()),
                        ),
                        height: double.infinity,
                        backgroundColor: Color(0xFF2D61AC)
                    ),
                  ),
                  Spacer(flex: 1,),
                  Flexible(
                    flex: 10,
                    child: _buildStyledButton(
                        context,
                        label: '받은 쪽지',
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ReceivedScreen()),
                        ),
                        height: double.infinity,
                        backgroundColor: Color(0xFF4DB8B5)
                    ),
                  ),
                  Spacer(flex: 1,),
                  Flexible(
                    flex: 10,
                    child: _buildStyledButton(
                        context,
                        label: '작성한 쪽지',
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => WroteScreen()),
                        ),
                        height: double.infinity,
                        backgroundColor: Color(0xFFCCEC7B)
                    ),
                  )
                ],
              )
          )
      ),
    );
  }

  Color lightenColor(Color color, [double amount = 0.2]) {
    final hsl = HSLColor.fromColor(color);
    final lightened = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return lightened.toColor();
  }

  Widget _buildStyledButton(
      BuildContext context, {
        required String label,
        required VoidCallback onPressed,
        required double height,
        required Color backgroundColor,
      }) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: lightenColor(backgroundColor, 0.2),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 140,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }
}
