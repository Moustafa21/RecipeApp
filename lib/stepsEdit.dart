import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class stepsEdit extends StatefulWidget {
  final String category;
  final String country;
  final String docID;
  final String title;
  const stepsEdit(this.category, this.country, this.docID, this.title);

  @override
  _stepsEditState createState() => _stepsEditState();
}

class _stepsEditState extends State<stepsEdit> {
  final _firestore = FirebaseFirestore.instance;
  late var Recipe;

  late String recipe;

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
        title: Text("${widget.title} حدث طريقة التحضير لـ",style: TextStyle(fontSize: 20),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(30),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'ادخل طريقة التحضير',
                      labelStyle:TextStyle(fontSize: 20),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 7,
                    onChanged: (val){
                      Recipe =val;
                    },
                  ),
                ),

                Padding(padding: EdgeInsets.all(30)),
                ButtonTheme(
                  height:60,
                  minWidth: 80,
                  child: RaisedButton(
                    onPressed: () async {
                      _firestore.collection("Items").doc(widget.country).collection(widget.country).doc(widget.category).collection(widget.category).doc(widget.docID).update({
                        'Recipe' : Recipe,
                      }
                      ).then((value) => Navigator.of(context).pop());
                    },
                    child: Text('حدث الطريقة',style:TextStyle(color:Colors.white,fontSize:20)),
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