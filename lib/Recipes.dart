import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/itemCards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Recipes extends StatelessWidget {
  final String category;
  final String country;

  Recipes(this.category, this.country);

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text(category,
            style: TextStyle(fontSize: 20),),
          backgroundColor: Color(0xff174354),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: _firestore
              .collection('Items')
              .doc(country)
              .collection(country)
              .doc(category)
              .collection(category)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    QueryDocumentSnapshot x = snapshot.data!.docs[i];
                    var snap = snapshot.data!.docs;
                    for (var item in snap) {
                      String id = item.id;
                    }
                    return itemCards(x['url'], x['RecipeName'], x['RecipeTime'],
                        x['Ingredients'], x['Recipe'], category, country,x.id);
                  });
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}