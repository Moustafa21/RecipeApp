import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Details.dart';
import 'itemCards.dart';

class Favorites extends StatelessWidget {
    final _firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  StreamBuilder(
          stream: _firestore.collection("users-favorites").doc(auth.currentUser!.email).collection("items").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,i){
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                  return itemCards(
                      x['url'],
                      x['RecipeName'],
                      x['RecipeTime'],
                      x['Ingredients'],
                      x['Recipe'],
                      'category',
                      'doc',);
                });
            }
                return Center(
                  child: CircularProgressIndicator());
          },
          )
    );
  }}