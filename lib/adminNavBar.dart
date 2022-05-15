import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/search1/search.dart';
import 'account.dart';
import 'chat.dart';
import 'adminAdd.dart';
import 'favorites.dart';
import 'filtercountries.dart';
import 'home/home.dart';
import 'home/newHome.dart';
import 'login.dart';
import 'register.dart';

class adminNavBar extends StatefulWidget {
  const adminNavBar({ Key? key }) : super(key: key);

  @override
  _adminNavBarState createState() => _adminNavBarState();
}

class _adminNavBarState extends State<adminNavBar> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late List pages;
  LogOut(){
    onpressed: () {
      _auth.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    };
  }

  int selectPageIndex = 0;

  void initState(){
    pages = [
      {
        'page': Home(),
        'label': "الرئيسية",
      },
      {
        'page': FilterCountry(),
        'label': "البلاد",
      },
      {
        'page': Add(),
        'label': "اضافة وصفة جديدة",
      },
      {
        'page': Chat(),
        'label': "تواصل",
      },
      {
        'page': LogOut(),
        'label': "تسجيل الخروج",
      },

    ];
    super.initState();
  }

  void selectPage(int value){
    setState(() {
      selectPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*   appBar: AppBar(
        title: Text(pages[selectPageIndex]['label']),
        backgroundColor: Color(0xff174354),
        ),*/

      body: pages[selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal[500],
        unselectedItemColor: Colors.black,
        currentIndex: selectPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "الرئيسية"
          ),
          /*     BottomNavigationBarItem(
             icon: Icon(Icons.home),
             label: "Chats"
             ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_alt),
            label: "الاقسام",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "اضافة",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_rounded),
              label: "تواصل"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'تسجيل خروج'
          ),
        ],
      ),
    );
  }
}