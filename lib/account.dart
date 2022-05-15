import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/profile.dart';

import 'chat.dart';
import 'login.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff174354),
        title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('الاعدادات',
              style: TextStyle(fontSize: 20),)),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            SizedBox(height: 20),
            ProfileMenu(
              text: 'حسابي',
              icon: Icons.account_circle,
              onpressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>myProfile()));
              },
            ),
            ProfileMenu(
              text: 'تواصل للمقترحات',
              icon: Icons.chat_bubble_rounded,
              onpressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Chat()));
              },
            ),
            ProfileMenu(
              text: 'عنا',
              icon: Icons.info,
              onpressed: () {},
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
            Expanded(child: Text(text)),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}