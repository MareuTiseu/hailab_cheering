import 'dart:math';

import 'package:cheering/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'gpt_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class WritingScreen extends StatefulWidget {
  const WritingScreen({super.key});

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final TextEditingController _textController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Color lightenColor(Color color, [double amount = 0.2]) {
    final hsl = HSLColor.fromColor(color);
    final lightened = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return lightened.toColor();
  }


  @override
  void dispose() {
    _textController.dispose(); // 리소스 정리
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('응원 쪽지 작성하기', style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),),
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
                    flex: 4,
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20,0,20,0),
                        child: Text(
                          '응원 쪽지는 이렇게 작성해보세요~',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 1,),
                  Flexible(
                    flex: 10,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20,20,20,20,),
                        child: TextField(
                          controller: _textController,
                          expands: true,
                          maxLines: null,
                          maxLength: 300, inputFormatters: [LengthLimitingTextInputFormatter(300)],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8),
                            hintText: '함께 일하고 있는 같은 구성원들에게 전하고 싶은 응원의 말을 작성해주세요',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 1,),
                ],
              )
          )
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade100,

        child: SizedBox(
          height: 60,
          child: Center(
            child: SizedBox(
              width: 200,
              child: TextButton(
                child: Text('다음'),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GptScreen(controller: _textController)
                    )
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)
                  ),
                  textStyle: TextStyle(
                      fontSize: 16
                  )
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}