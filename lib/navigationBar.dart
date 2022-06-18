import 'package:flutter/material.dart';
import 'account.dart';
import 'favorites.dart';
import 'filtercountries.dart';
import 'home.dart';
import 'search.dart';

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
          selectedItemColor: Colors.teal[500],
          selectedFontSize: 15,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.black,
          currentIndex: selectPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 25), label: "الرئيسية"),
            BottomNavigationBarItem(
              icon: Icon(Icons.filter_alt, size: 25),
              label: "التصنيفات",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 25), label: "المفضلة"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, size: 25), label: "حسابي"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 25), label: "بحث"),
          ],
        ),
      ),
    );
  }
}
