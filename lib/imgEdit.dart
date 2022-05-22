import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/Details.dart';

class imgEdit extends StatefulWidget {
  final String category;
  final String country;
  final String docID;
  final String title;
  final String ing;
  final String steps;
  final String url;
  final String duration;

  const imgEdit(this.category, this.country, this.docID, this.title, this.ing,
      this.steps, this.url, this.duration);

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
      _image = File(pickedfile!.path);
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff174354),
        title: Text(
          " تحديث صورة ${widget.title}",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(30)),
                  Card(
                      color: Colors.grey[200],
                      child: (_image != null)
                          ? Image.file(
                        _image,
                        width: 150,
                        height: 150,
                        fit: BoxFit.fill,
                      )
                          : Image(
                        image: AssetImage('assets/upload.png'),
                        width: 160,
                        height: 160,
                      )),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'اضف صورة',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.teal[600],
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Icon(
                          Icons.add_circle,
                          color: Colors.teal[500],
                          size: 25,
                        ),
                      ],
                    ),
                    onTap: getImage,
                  ),
                  Padding(padding: EdgeInsets.all(50)),
                  ButtonTheme(
                    height: 50,
                    minWidth: 150,
                    child: RaisedButton(
                      onPressed: () async {
                        await uploadPic(context);
                        _firestore
                            .collection("Items")
                            .doc(widget.country)
                            .collection(widget.country)
                            .doc(widget.category)
                            .collection(widget.category)
                            .doc(widget.docID)
                            .update({
                          'url': downloadUrl,
                        }).then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                    widget.title,
                                    downloadUrl,
                                    widget.duration,
                                    widget.ing,
                                    widget.steps,
                                    widget.category,
                                    widget.country,
                                    widget.docID))));
                      },
                      child: Text(
                        'حدث الصورة',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.teal[500],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}