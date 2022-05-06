import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'resetPassword.dart';

class myProfile extends StatefulWidget {
  const myProfile({Key? key}) : super(key: key);

  @override
  State<myProfile> createState() => _myProfileState();
}

class _myProfileState extends State<myProfile> {
  var _auth = FirebaseAuth.instance;
  var logedInUSer;
  late var newEmail;
  bool showSpinner = false;
  var _controller = TextEditingController();
  final _firestore = FirebaseFirestore.instance;


  getCuurrentUser() {
    User? user = _auth.currentUser?.email as User?;
    logedInUSer = user?.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(logedInUSer ?? "S")),
      body: Builder(builder: (context) {
        return ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(5)),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.black,
                  size: 110,
                ),
                alignment: Alignment.center,
              ),
              Center(
                child: Text(_auth.currentUser!.email??"",
                  style: TextStyle(fontSize: 20,
                    color: Colors.deepPurple[800],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(5)),

                  Container(
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Enter new email',
                        labelStyle: TextStyle(fontSize: 20),
                      ),
                      onChanged: (val) {
                        newEmail = val;
                      },
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(15)),

                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> ResetPassword()),
                      );
                    },
                    child: Text("Reset Password?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(80)),
                  RaisedButton(
                    onPressed: () async {
                      _auth.currentUser!
                          .updateEmail(newEmail)
                          .then((value) => showSpinner = true)
                          .then((value) => Scaffold.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Email updated successfully'))))
                          .then((value) => _controller.clear())
                          .then((value) => showSpinner = false);
                    },
                    child: Text('update email'),
                    color: Colors.teal[500],
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}