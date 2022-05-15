import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'itemCards.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> cats = ["Iraqi", "Lebanese","Moroccan"];

  //cats.shuffle();
  List<String> rtv = ["Chickens", "Pastries"];

  sfl() {
  }

  @override
  void initState() {
    cats.shuffle();
    rtv.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(rtv[1]),),
        body:
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Items").doc(cats[0])
              .collection(cats[0]).doc(rtv[0]).collection(rtv[0])
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, i) {
                    QueryDocumentSnapshot x = snapshot.data!.docs[i];

                    return itemCards(
                        x['url'],
                        x['RecipeName'],
                        x['RecipeTime'],
                        x['Ingredients'],
                        x['Recipe'],
                        "",
                        "",
                        x.id);
                  });
            }
            return Center(
                child: CircularProgressIndicator());
          },
        )
    );
  }
}