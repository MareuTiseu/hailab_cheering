import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screen/home_screen.dart';
import './screen/splash_screen.dart';
import './screen/login_screen.dart';
import './services/notification_service_platform.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // 웹이 아닌 경우에만 알림 서비스 초기화
    if (!kIsWeb) {
      await NotificationService().initialize();
      await NotificationService().scheduleDailyReminder();
    } else {
      print('웹 환경에서는 푸시 알림이 지원되지 않습니다. UI만 확인 가능합니다.');
    }

    runApp(const MyApp());
  } catch (e) {
    print('초기화 실패: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HAILAB Cheering App',
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}

