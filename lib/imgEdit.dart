import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class imgEdit extends StatefulWidget {
  final String category;
  final String docID;
  final String title;

  const imgEdit(this.category,  this.docID, this.title);

  @override
  _imgEditState createState() => _imgEditState();
}

class _imgEditState extends State<imgEdit> {
  final _firestore = FirebaseFirestore.instance;
  var _image;
  late String downloadUrl;
  final picker = ImagePicker();
  bool showSpinner = false;

  @override
  void intistate() {
    super.initState();
  }

  Future getImage() async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedfile!.path );
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(_image);
    setState(() {
      showSpinner = true;
    });
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    downloadUrl = imageUrl.toString();
    setState(() {
      showSpinner = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color(0xff174354),
        titleSpacing: 30,
        title: Text("Edit ${widget.title} image",style: TextStyle(fontSize: 30),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(5)),
                Card(
                    child:
                    (_image!=null)
                        ?Image.file(_image,width: 100, height: 100,fit: BoxFit.fill,)
                        :Image(image: AssetImage ('images/Edit.png'),width: 60,height: 60,)
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Edit Image',
                        style: TextStyle(
                          color: Colors.teal[600],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Icon(Icons.add_circle,color: Colors.teal[500],),
                    ],
                  ),
                  onTap: getImage,
                ),


                Padding(padding: EdgeInsets.all(10)),
                RaisedButton(
                  onPressed: () async {
                    await uploadPic(context);
                    _firestore.collection("Items").doc(widget.category).collection(widget.category).doc(widget.docID).update({
                      'url': downloadUrl,
                    }
                    ).then((value) =>
                        Navigator.of(context).pop());

                  },
                  child: Text('Edit Image'),
                  color: Colors.teal[500],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}