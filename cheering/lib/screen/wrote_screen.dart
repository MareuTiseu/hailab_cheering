import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class WroteScreen extends StatefulWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  const WroteScreen({super.key});

  @override
  State<WroteScreen> createState() => _WroteScreenState();
}

class _WroteScreenState extends State<WroteScreen> {
  final TextEditingController _editingController = TextEditingController();
  int? expandedIndex;
  String? userId;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      userId = currentUser?.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return Scaffold(
        body: Center(child: Text('로그인이 필요합니다.')),
      );
    }

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
        title: Text('작성한 쪽지 서랍', style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500)),
      ),
      body: Align(
        alignment: Alignment.center,
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: 0.9,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('user_texts')
                .where('authorId', isEqualTo: userId)
                .where('deleted', isEqualTo: false)
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              print('snapshot.hasData: ${snapshot.hasData}');
              print('docs: ${snapshot.data?.docs.length}');

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('작성한 쪽지가 없습니다.'));
              }

              final docs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  final text = doc['text'] ?? '';
                  final isExpanded = index == expandedIndex;

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            expandedIndex = isExpanded ? null : index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          height: isExpanded ? 120 : 50,
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
                                child: Text(
                                  text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                  maxLines: isExpanded ? null : 1,
                                  overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                                ),
                              ),
                              if (isExpanded)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(Icons.delete_outline, color: Colors.redAccent),
                                    onPressed: () async {
                                      await doc.reference.update({"deleted": true});
                                      setState(() {
                                        if (expandedIndex == index) {
                                          expandedIndex = null;
                                        }
                                      });
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
