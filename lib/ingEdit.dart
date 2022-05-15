import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ingEdit extends StatefulWidget {
  final String category;
  final String country;
  final String docID;
  final String title;

  const ingEdit(this.category,  this.country,this.docID, this.title );

  @override
  _ingEditState createState() => _ingEditState();
}

class _ingEditState extends State<ingEdit> {
  final _firestore = FirebaseFirestore.instance;
  late var Ingredients;
  bool showSpinner = false;


  @override
  void intistate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff174354),
        title: Text("${widget.category} تحديث المكونات لـ",style: TextStyle(fontSize: 20),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(50),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'ادخل المكونات',
                      labelStyle:TextStyle(fontSize: 20),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 7,
                    onChanged: (val){
                      Ingredients =val;
                    },
                  ),
                ),

                Padding(padding: EdgeInsets.all(30)),
                ButtonTheme(
                  height: 50,
                  minWidth: 80,
                  child: RaisedButton(
                    onPressed: () async {
                      _firestore.collection("Items").doc(widget.country).collection(widget.country).doc(widget.category).collection(widget.category).doc(widget.docID).update({
                        'Ingredients' : Ingredients,
                      }
                      ).then((value) => Navigator.of(context).pop()
                      );
                    },
                    child: Text('حدث المكونات',style: TextStyle(color:Colors.white,fontSize: 20),),
                    color: Colors.teal[500],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}