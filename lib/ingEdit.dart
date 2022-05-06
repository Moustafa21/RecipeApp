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
  final String docID;
  final String title;

  const ingEdit(this.category, this.docID, this.title);

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
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color(0xff174354),
        titleSpacing: 30,
        title: Text(
          "Edit ${widget.title} ingredients",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter the Ingredients',
                    labelStyle: TextStyle(fontSize: 20),
                  ),
                  maxLines: 7,
                  onChanged: (val) {
                    Ingredients = val;
                  },
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              RaisedButton(
                onPressed: () async {
                  await _firestore
                      .collection("Items")
                      .doc(widget.category)
                      .collection(widget.category)
                      .doc(widget.docID)
                      .update({
                    'Ingredients': Ingredients,
                  });
                },
                child: Text('Update ingredients'),
                color: Colors.teal[500],
              ),
            ],
          )),
    );
  }
}
