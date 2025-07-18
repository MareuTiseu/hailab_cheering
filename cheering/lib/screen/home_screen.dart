import 'package:flutter/material.dart';
import 'writing_screen.dart';
import 'received_screen.dart';
import 'wrote_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            // side: BorderSide(
            //   color: Colors.grey.shade100,
            //   width: 1
            // )
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
                    // border: Border.all(
                    //   color: Colors.grey.shade200,
                    //   width: 1,
                    // )
                  ),
                ),
              ),
            ),

            // 중앙 텍스트
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
