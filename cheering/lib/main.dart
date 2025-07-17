import 'package:flutter/material.dart';
import './screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [Icon(Icons.star)],
          title: Text('HAILAB 응원쪽지 실험', style: TextStyle(color: Colors.orangeAccent),),
        ),
        body: HomeScreen(),
        bottomNavigationBar: BottomAppBar(),
      )
    );
  }
}

