import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Details.dart';
import 'package:favorite_button/favorite_button.dart';

class itemCards2 extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String duration;
  final String ing;
  final String steps;
  final String category;
  final String country;
  final String docID;

  itemCards2(
      @required this.imageUrl,
      @required this.title,
      @required this.duration,
      this.ing,
      this.steps,
      this.country,
      this.category,
      this.docID);

  bool isfav = false;

  void selectMeal(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
          builder: (context) =>
              Details(title, imageUrl, ing, steps, docID, category,country)),
    );
  }

  Future addToFavorite() async {
    isfav = true;
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("users-favorites");
    return collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(title)
        .set({
      'url': imageUrl,
      'Recipe': steps,
      'Ingredients': ing,
      'RecipeName': title,
      'RecipeTime': duration,
    }).then((value) => print(isfav));
  }

  Future unFavorite() async {
    isfav = false;
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("users-favorites");
    return collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(title)
        .delete()
        .then((value) => print(isfav));
  }

  Future delete() async {
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("Items");
    return collectionRef
        .doc(country)
        .collection(country)
        .doc(category)
        .collection(category)
        .doc(docID)
        .delete();
  }

  var _auth = FirebaseAuth.instance;
  var logedInUSer;

  getCuurrentUser() {
    User? user = _auth.currentUser?.email as User?;
    logedInUSer = user?.email;
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 130,
      width: 250,
      child: FlatButton(
          onPressed: () => selectMeal(context),
          child: Container(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 150,
                    width:double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),Text(title,
                  style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),
                  //softWrap: true,
                  //overflow: TextOverflow.fade
                ),
                // Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Row(
                //         children: [
                //           Icon(Icons.timer),
                //           //SizedBox(width: 6),
                //           Text("$duration min"),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           FavoriteButton(
                //             //     isFavorite: true,
                //             iconColor: Colors.red,
                //             iconDisabledColor: Colors.black26,
                //             valueChanged: (_isFavorite) {
                //               if (isfav == false) {
                //                 addToFavorite();
                //               } else if (isfav == true) {
                //                 unFavorite();
                //               }
                //             },
                //           ),
                //         ],
                //       ),
                //       Visibility(
                //           child: Row(
                //             children: [
                //               IconButton(
                //                 onPressed: () => delete(),
                //                 icon: Icon(Icons.delete),
                //               ),
                //             ],
                //           ),
                //           visible:
                //           _auth.currentUser?.email == 'tatamagdy2@gmail.com'
                //               ? true
                //               : false),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
    );

  }
}
