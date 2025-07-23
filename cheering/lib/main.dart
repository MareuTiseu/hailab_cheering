import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screen/home_screen.dart';
import './screen/splash_screen.dart';
import './screen/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();  // firebase 사용하려면 비동기 방식의 초기화가 먼저 필요. 자세히 이해 못함.
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  } catch (e) {
    print('Firebase 초기화 실패: $e');
  }

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // runApp(const MyApp());
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
            return SplashScreen(); // 로딩화면
          } else if (snapshot.hasData) {
            return HomeScreen(); // 로그인된 상태
          } else {
            return LoginScreen(); // 로그인 필요
          }
        },
      ),
    );
  }
}

