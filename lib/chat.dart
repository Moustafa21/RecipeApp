import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chatCard.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _fireStore = FirebaseFirestore.instance;
  String? newMsg;
  var _conttroller = TextEditingController();
  late bool isMe;
  ScrollController scrollController = new ScrollController();
  var _auth = FirebaseAuth.instance;
  var logedInUSer;

  getCuurrentUser() {
    User? user = _auth.currentUser;
    logedInUSer = user?.email;
  }

  @override
  void initState() {
    getCuurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text("المحادثة"),
        leading: BackButton(),
        backgroundColor: Color(0xff174354),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _fireStore
                    .collection('Chat')
                    .orderBy('sort', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var items = snapshot.data!.docs;
                  List<Widget> chatList = [];
                  for (var item in items) {
                    String msg = (item.data() as dynamic)['Msg'];
                    String sender = (item.data() as dynamic)['sender'];
                    if (sender == logedInUSer) {
                      isMe = true;
                    } else {
                      isMe = false;
                    }
                    var itemList = ChatCard(
                      Sender: sender,
                      Msg: msg,
                      isMe: isMe,
                    );
                    chatList.addAll([
                      itemList,
                      SizedBox(
                        height: 10,
                      )
                    ]);
                  }

                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(15),
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        WidgetsBinding.instance?.addPostFrameCallback((_) {
                          if (scrollController.hasClients) {
                            scrollController.jumpTo(
                                scrollController.position.maxScrollExtent);
                          }
                        });
                        return Column(
                          children: [chatList[index]],
                        );
                      },
                    ),
                  );
                }),
            Container(
              padding: EdgeInsets.all(12),
              color: Colors.grey[200],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (val) {
                        newMsg = val;
                      },
                      controller: _conttroller,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'ارسل رسالة',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      _conttroller.clear();
                      await _fireStore.collection('Chat').add({
                        'Msg': newMsg,
                        'sort': DateTime.now().microsecondsSinceEpoch,
                        'sender': logedInUSer,
                      });
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.teal[500],
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
