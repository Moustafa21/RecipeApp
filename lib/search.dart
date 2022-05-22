import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dataControl.dart';
import 'package:untitled/itemCards.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  late QuerySnapshot snapshotData;
  bool isExcecuted = false;

  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
              onTap: () {},
              child: itemCards(
                  (snapshotData.docs[i].data() as dynamic)['url'],
                  (snapshotData.docs[i].data() as dynamic)['RecipeName'],
                  (snapshotData.docs[i].data() as dynamic)['RecipeTime'],
                  (snapshotData.docs[i].data() as dynamic)['Ingredients'],
                  (snapshotData.docs[i].data() as dynamic)['Recipe'],
                  "",
                  "",
                  ""));
        },
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: (FloatingActionButton(
            child: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                isExcecuted = false;
              });
            },
          )),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff174354),
            title: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'ادخل الاسم',
                  hintStyle: TextStyle(color: Colors.white)),
              controller: searchController,
            ),
            actions: [
              GetBuilder<DataController>(
                init: DataController(),
                builder: (val) {
                  return IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        val.queryData(searchController.text).then((value) {
                          snapshotData = value;
                          setState(() {
                            isExcecuted = true;
                          });
                        });
                      });
                },
              )
            ],
          ),
          body: isExcecuted
              ? searchedData()
              : Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              child: Text(
                'ابحث عن الوصفة',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
        ),
      ),
    );
  }
}