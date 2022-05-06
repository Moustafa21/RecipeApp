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
          color: (isMe)
              ?Colors.teal
              :Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: (isMe)?Radius.circular(20):Radius.circular(0),
              bottomRight:(isMe)?Radius.circular(0):Radius.circular(20),
          )
      ),
      margin: (isMe)
          ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.5)
          : EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.5),
      //elevation: 15,
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: (isMe == true)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(Sender),
              Text(Msg ),
            ],
          ),
        ),
      ),
    );
  }
}
