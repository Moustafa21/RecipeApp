import 'package:flutter/material.dart';
import 'package:untitled/profile.dart';
import 'package:untitled/search1/search1.dart';
import 'chat.dart';
import 'favorites.dart';
import 'adminAdd.dart';
import 'filtercountries.dart';
class bottomNavBar extends StatefulWidget {
  const bottomNavBar({ Key? key }) : super(key: key);

  @override
  _bottomNavBarState createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {

  late List pages;


  int selectPageIndex = 0;

  void initState(){
    pages = [
      {
        'page': Chat(),
        'label': 'chats',
      },
      {
        'page': FilterCountry(),
        'label': "Categories",
      },
      {
        'page': Add(),
        'label': "Add items",
      },
      {
        'page': myProfile(),
        'label': "profile",
      },
      {
        'page': Favorites(),
        'label': "favorite",
      },
      {
        'page': Searching(),
        'label': "search",
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
      appBar: AppBar(
        title: Text(pages[selectPageIndex]['label']),
        backgroundColor: Color(0xff174354),
      ),

      body: pages[selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal[300],
        unselectedItemColor: Colors.black,
        currentIndex: selectPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "Chats"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_alt),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "profile"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "favorite"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "search"
          ),

        ],
      ),
    );
  }
}