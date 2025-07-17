import 'package:flutter/material.dart';
import 'writing_screen.dart';
import 'received_screen.dart';
import 'wrote_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
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
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: TextButton(
                      child: Text('●   작성하기'),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WritingScreen())
                        );
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orangeAccent,
                          textStyle: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.04
                          )
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 1,),
                Flexible(
                  flex: 10,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: TextButton(
                      child: Text('●   받은 쪽지'),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ReceivedScreen())
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orangeAccent,
                        textStyle: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.04
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 1,),
                Flexible(
                  flex: 10,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: TextButton(
                      child: Text('●   작성한 쪽지'),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WroteScreen())
                        );
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orangeAccent,
                          textStyle: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.04
                          )
                      ),
                    ),
                  ),
                )
              ],
            )
        )
    );
  }
}