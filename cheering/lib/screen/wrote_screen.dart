import 'package:flutter/material.dart';




class WroteScreen extends StatefulWidget {
  const WroteScreen({super.key});

  @override
  State<WroteScreen> createState() => _WroteScreenState();
}

class _WroteScreenState extends State<WroteScreen> {
  List<String> entries = List.generate(19, (i) => '${i + 1}');
  int? expandedIndex;
  final TextEditingController _editingController = TextEditingController();

  void _deleteEntry(int index) {
    setState(() {
      entries.removeAt(index);
      if (expandedIndex == index) {
        expandedIndex = null;
      } else if (expandedIndex != null && index < expandedIndex!) {
        expandedIndex = expandedIndex! - 1;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('작성한 쪽지 서랍', style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),),
      ),
      body: Align(
          alignment: Alignment.center,
          child: FractionallySizedBox(
              widthFactor: 0.8,
              heightFactor: 0.9,
              alignment: Alignment.center,
              child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  final isExpanded = index == expandedIndex;
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            expandedIndex = isExpanded ? null: index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          height: isExpanded ? 120: 50,
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),

                            ),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text('Entry ${entries[index]}', style: TextStyle(fontSize: 16, color: Colors.black),),
                              ),
                              if (isExpanded)
                                Positioned(
                                  top: 0, right: 0,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.delete_outline, color: Colors.redAccent,),
                                        onPressed: () => _deleteEntry(index),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.send, color: Colors.grey,),
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('전송 기능'))
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4,)
                    ],
                  );
                },
              )
          )
      ),
      // bottomNavigationBar: BottomAppBar(),
    );
  }
}
