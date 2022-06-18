import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../itemCards.dart';

class Favorites extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "قائمة المفضلة",
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: Color(0xff174354),
            automaticallyImplyLeading: false,
          ),
          body: StreamBuilder(
            stream: _firestore
                .collection("users-favorites")
                .doc(auth.currentUser!.email)
                .collection("items")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.data?.size == 0) {
                return Center(child: Text(".تصفح لاضافة وصفاتك المفضلة"));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, i) {
                      QueryDocumentSnapshot x = snapshot.data!.docs[i];
                      return itemCards(
                          x['url'],
                          x['RecipeName'],
                          x['RecipeTime'],
                          x['Ingredients'],
                          x['Recipe'],
                          "cate",
                          "",
                          "doc");
                    });
              }
            },
          )),
    );
  }
}
