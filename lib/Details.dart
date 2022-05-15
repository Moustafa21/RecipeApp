import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/imgEdit.dart';
import 'package:untitled/ingEdit.dart';
import 'package:untitled/login.dart';
import 'package:untitled/stepsEdit.dart';
import 'imgEdit.dart';
import 'ingEdit.dart';
import 'stepsEdit.dart';

class Details extends StatelessWidget {
  final String ing;
  final String steps;
  final String url;
  final String name;
  final String category;
  final String country;
  final String docID;

  Details(this.name, this.url, this.ing, this.steps, this.category, this.country,this.docID);


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

  var _auth = FirebaseAuth.instance;
  var logedInUSer;
  getCuurrentUser() {
    User? user = _auth.currentUser?.email as User?;
    logedInUSer = user?.email;
  }
  @override
  Widget build(BuildContext context) {
    //  final mealID = ModalRoute.of(context)!.settings.arguments as String;
    // final selectedMeal = DUMMY_mealS.firstWhere((meal) => meal.id == mealID);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff174354),
        title: Text(name,
          style: TextStyle(fontSize: 20),),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(url,
                  fit: BoxFit.cover,
                ),
              ),
              Visibility(
                  child: IconButton(
                    padding:EdgeInsets.symmetric(horizontal:250),
                    iconSize: 45,
                    onPressed:()=> Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>   imgEdit(category, country,docID, name))).then((value) => Navigator.of(context).pop()),
                    icon: Icon(Icons.photo_camera_back_outlined),
                  ),
                  visible:  _auth.currentUser?.email =='admin@gmail.com'? true: false
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [buildSectionTitle(context, "المكونات"),
                  Visibility(
                      child: IconButton(
                        onPressed:()=> Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>   ingEdit(category, country,docID, name))).then((value) => Navigator.of(context).pop()),
                        icon: Icon(Icons.edit),
                      ),
                      visible:  _auth.currentUser?.email =='admin@gmail.com'? true: false
                  ),
                ],
              ),
              buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) =>
                  //Column
                  Card(
                    color: Colors.grey,
                    child: Padding(padding: const EdgeInsets.symmetric(vertical:5, horizontal: 10),
                      child: Text(ing),
                    ),
                    //children: [
                    // ListTile(
                    /* leading: CircleAvatar(
                      backgroundColor: Colors.teal[500],
                      child: Text("#${index+1}"),
                    ),*/
                    //title: Text(ing),
                    //),
                    //Divider(),
                    //],
                  ),
                  itemCount: 1,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [buildSectionTitle(context, "طريقة التحضير"),
                  Visibility(
                      child: IconButton(
                        onPressed:()=> Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>   stepsEdit(category, country,docID, name))).then((value) => Navigator.of(context).pop()),
                        icon: Icon(Icons.edit),
                      ),
                      visible:  _auth.currentUser?.email =='admin@gmail.com'? true: false
                  ),
                ],
              ),
              buildContainer( ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal[500],
                        child: Text("#${index+1}"),
                      ),
                      title: Text(steps),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: 1,
              ),)
            ],
          ),
        ),
      ),
      /*  floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff449f96),
        onPressed: ()=> togglefav(mealID),
        child: Icon(
          isfavorite(mealID) ? Icons.favorite_sharp : Icons.favorite_outline
          ),
      ),*/
    );
  }
}