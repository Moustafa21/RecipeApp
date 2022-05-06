import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/imgEdit.dart';
import 'package:untitled/ingEdit.dart';
import 'package:untitled/login.dart';
import 'package:untitled/stepsEdit.dart';
import 'Recipes.dart';
import 'package:untitled/countryItems.dart';

class Details extends StatelessWidget {
  final String ing;
  final String steps;
  final String url;
  final String name;
  final String category;
  final String docID;

  Details(this.name, this.url, this.ing, this.steps, this.category, this.docID);

  var _auth = FirebaseAuth.instance;
  var logedInUSer;

  getCuurrentUser() {
    User? user = _auth.currentUser?.email as User?;
    logedInUSer = user?.email;
  }

  Widget buildSectionTitle(BuildContext ctx, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    //  final mealID = ModalRoute.of(context)!.settings.arguments as String;
    // final selectedMeal = DUMMY_mealS.firstWhere((meal) => meal.id == mealID);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff174354),
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
            Visibility(
                child: IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 320),
                  iconSize: 45,
                  onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  imgEdit(category, docID, name)))
                      .then((value) => Navigator.of(context).pop()),
                  icon: Icon(Icons.photo_camera_back_outlined),
                ),
                visible: _auth.currentUser?.email == 'admin@gmail.com'
                    ? true
                    : false),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              buildSectionTitle(context, "Ingredients"),
              Visibility(
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ingEdit(category, docID, name))),
                  ),
                  visible: _auth.currentUser?.email == 'tatamagdy2@gmail.com'
                      ? true
                      : false),
            ]),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) =>
                    //Column
                    Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(ing),
                  ),
                ),
                itemCount: 1,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              buildSectionTitle(context, "Steps"),
              Visibility(
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                stepsEdit(category, docID, name))),
                  ),
                  visible: _auth.currentUser?.email == 'tatamagdy2@gmail.com'
                      ? true
                      : false),
            ]),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal[500],
                        child: Text("#${index + 1}"),
                      ),
                      title: Text(steps),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
