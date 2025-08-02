// lib/screen/received_screen.dart
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'writing_screen.dart'; // 🆕 추가
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReceivedScreen extends StatefulWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  const ReceivedScreen({super.key});

  @override
  State<ReceivedScreen> createState() => _ReceivedScreenState();
}

class _ReceivedScreenState extends State<ReceivedScreen> {
  final TextEditingController _editingController = TextEditingController();
  int? expandedIndex;
  String? userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid;
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
        title: Text(
          '받은 쪽지 서랍',
          style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          // 🆕 응원 메시지 보내기 버튼 추가
          Container(
            margin: EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => WritingScreen()),
                );
              },
              icon: Icon(Icons.edit, color: Colors.white),
              label: Text(
                '나도 다른 동료에게 응원 메시지 보내기',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2D61AC),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ),

          // 기존 받은 쪽지 목록
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                heightFactor: 0.9,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('user_texts')
                      .where('authorId', isNotEqualTo: userId)
                      .where('deleted', isEqualTo: false)
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.mail_outline, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              '받은 쪽지가 없습니다.',
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                            ),
                            SizedBox(height: 24),
                            Text(
                              '동료들이 보낸 응원 메시지가\n여기에 나타납니다',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                            ),
                          ],
                        ),
                      );
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
                                height: isExpanded ? 120 : 60,
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isExpanded ? Color(0xFF4DB8B5) : Colors.grey.shade300,
                                    width: isExpanded ? 2 : 1,
                                  ),
                                  boxShadow: isExpanded ? [
                                    BoxShadow(
                                      color: Color(0xFF4DB8B5).withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ] : null,
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        text,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: isExpanded ? FontWeight.w500 : FontWeight.normal,
                                        ),
                                        maxLines: isExpanded ? null : 2,
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
                            SizedBox(height: 8),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
