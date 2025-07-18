import 'package:cheering/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'wrote_screen.dart';
import 'home_screen.dart';

class GptScreen extends StatelessWidget {
  final TextEditingController controller;
  const GptScreen({super.key, required this.controller});

  Color lightenColor(Color color, [double amount = 0.2]) {
    final hsl = HSLColor.fromColor(color);
    final lightened = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return lightened.toColor();
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
        title: Text('작성한 쪽지 살펴보기', style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),),
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
                    flex: 2,
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20,0,20,0),
                        child: Text(
                          '이렇게 바꿔보는건 어떨까요~',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 1,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        SizedBox(width: 8,),
                        Text('기존', style: TextStyle(),)
                      ],
                    )
                  ),
                  SizedBox(height: 8,),
                  Flexible(
                    flex: 6,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20,20,20,20,),
                        child: Center(
                          child: Text(
                            controller.text.isNotEmpty
                                ? controller.text
                                : '작성된 쪽지가 없습니다.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Spacer(flex: 1,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SizedBox(width: 8,),
                          Text('바꿔보기', style: TextStyle(),)
                        ],
                      )
                  ),
                  SizedBox(height: 8,),
                  Flexible(
                    flex: 6,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20,20,20,20,),
                        child: Center(
                          child: Text(
                            'GPT api 사용 예정',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: TextButton(
                    child: Text('저장하기'),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WroteScreen())
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
                SizedBox(
                  width: 200,
                  child: TextButton(
                    child: Text('전송하기'),
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                            (route) => false, // ❗ 모든 기존 라우트 제거
                      );
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF2D61AC),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)
                        ),
                        textStyle: TextStyle(
                            fontSize: 16
                        )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
