import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'adminProfile.dart';
import 'adminAdd.dart';
import 'filtercountries.dart';
import 'home.dart';
import 'login.dart';

class adminNavBar extends StatefulWidget {
  const adminNavBar({Key? key}) : super(key: key);

  @override
  _adminNavBarState createState() => _adminNavBarState();
}

class _adminNavBarState extends State<adminNavBar> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late List pages;
  int selectPageIndex = 0;

  void initState() {
    pages = [
      {
        'page': FilterCountry(),
      },
      {
        'page': Add(),
      },
      {
        'page': adminAcc(),
      },
    ];
    super.initState();
  }

  void selectPage(int value) {
    setState(() {
      selectPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectPageIndex]['page'],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black, width: 1.0))),
        child: BottomNavigationBar(
          onTap: selectPage,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.teal[500],
          showUnselectedLabels: false,
          selectedFontSize: 15,
          unselectedItemColor: Colors.black,
          currentIndex: selectPageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.filter_alt, size: 25),
              label: "التصنيفات",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add, size: 25),
              label: "اضافة",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 25,
              ),
              label: "الحساب",
            ),
          ],
        ),
      ),
    );
  }
}
