import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class stepsEdit extends StatefulWidget {
  final String category;
  final String docID;
  final String title;
  const stepsEdit(this.category,  this.docID, this.title);

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
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Color(0xff174354),
            titleSpacing: 30,
            title: Text("Edit ${widget.title} steps",style: TextStyle(fontSize: 30),
            ),
          ),
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: ListView(
                  children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter the Recipe',
                              labelStyle:TextStyle(fontSize: 20),
                            ),
                            maxLines: 7,
                            onChanged: (val){
                              Recipe =val;
                            },
                          ),
                        ),
            
                        Padding(padding: EdgeInsets.all(10)),
                        RaisedButton(
                          onPressed: () async {
                            _firestore.collection("Items").doc(widget.category).collection(widget.category).doc(widget.docID).update({
                              'Recipe' : Recipe,
                            }
                            );
                          },
                          child: Text('Update Steps'),
                          color: Colors.teal[500],
                        ),
                      ],
                    )
                ),
            );
  }
}
