import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat.dart';
import 'login.dart';

class adminAcc extends StatefulWidget {
  const adminAcc({Key? key}) : super(key: key);

  @override
  State<adminAcc> createState() => _adminAccState();
}

class _adminAccState extends State<adminAcc> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff174354),
          title: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'الحساب',
                style: TextStyle(fontSize: 20),
              )),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              SizedBox(height: 20),
              ProfileMenu(
                text: 'تواصل مع المستخدمين',
                icon: Icons.chat_rounded,
                onpressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Chat()));
                },
              ),
              ProfileMenu(
                text: 'تسجيل خروج',
                icon: Icons.logout,
                onpressed: () {
                  _auth.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu(
      {Key? key,
        required this.text,
        required this.icon,
        required this.onpressed})
      : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: onpressed,
        color: Color(0xfff5f6f9),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(text,
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}