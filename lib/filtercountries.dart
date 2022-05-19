import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'countryItems.dart';
class FilterCountry extends StatelessWidget {
  FilterCountry({Key? key}) : super(key: key);
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text(
            "المطابخ",
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Color(0xff174354),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: _firestore.collection("Items").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data?.size == 0) {
              return Center(
                  child:
                  Text("!مطبخنا فارغ، تواصل معنا لاضافة مطابخك المفضلة"));
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(25),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                  return country_items(x.id, x['img']);
                },
              );
            }
          },
        ),
      ),
    );
  }
}