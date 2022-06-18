import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  ChatCard({required this.Sender, required this.Msg, required this.isMe});

  final String Sender;
  final String Msg;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: (isMe) ? Color(0xff005c4b) : Color(0xff174354),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: (isMe) ? Radius.circular(20) : Radius.circular(0),
            bottomRight: (isMe) ? Radius.circular(0) : Radius.circular(20),
          )),
      margin: (isMe)
          ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.32)
          : EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.32),
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: (isMe == true)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                  child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(Sender,
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold)))),
              Divider(
                height: 5,
                color: Colors.black87,
                indent: 10,
                endIndent: 0,
              ),
              Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(Msg,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15))),
            ],
          ),
        ),
      ),
    );
  }
}
