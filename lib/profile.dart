import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          logedInUSer ?? "حسابي",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Color(0xff174354),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Builder(builder: (context) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: ListView(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(30)),
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
                  child: SelectableText(
                    _auth.currentUser!.email ?? "",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.indigo[800],
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
                          labelText: 'ادخل بريد الكتروني جديد',
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (val) {
                          newEmail = val;
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    RaisedButton(
                      onPressed: () async {
                        _auth.currentUser!
                            .updateEmail(newEmail)
                            .then((value) => showSpinner = true)
                            .then((value) => Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'تم تحديث البريد الالكتروني بنجاح'))))
                            .then((value) => _controller.clear())
                            .then((value) => showSpinner = false);
                      },
                      child: Text('حدث البريد الالكتروني',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      color: Colors.teal[700],
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPassword()),
                        );
                      },
                      child: Text(
                        "نسيت كلمة المرور؟",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
