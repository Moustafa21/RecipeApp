import 'package:flutter/material.dart';
import 'package:untitled/search1/search.dart';
import 'account.dart';
import 'favorites.dart';
import 'filtercountries.dart';
import 'home.dart';

class bottomNavBar extends StatefulWidget {
  const bottomNavBar({Key? key}) : super(key: key);

  @override
  _bottomNavBarState createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  late List pages;

  int selectPageIndex = 0;

  void initState() {
    pages = [
      {
        'page': Home(),
      },
      {
        'page': FilterCountry(),
      },
      {
        'page': Favorites(),
      },
      {
        'page': Account(),
      },
      {
        'page': Search(),
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
          selectedFontSize: 15,
          unselectedItemColor: Colors.black,
          currentIndex: selectPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30), label: "الرئيسية"),
            BottomNavigationBarItem(
              icon: Icon(Icons.filter_alt, size: 30),
              label: "التصنيفات",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 30), label: "المفضلات"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 30), label: "حسابي"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 30), label: "بحث"),
          ],
        ),
      ),
    );
  }
}