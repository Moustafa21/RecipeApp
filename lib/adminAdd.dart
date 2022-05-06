import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:untitled/login.dart';
import 'package:untitled/reuseableField.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var _formkey = GlobalKey<FormState>();
  bool showSpinner = false;
  var _image;
  var Ingredients;
  var RecipeName;
  var Recipe;
  var category;
  String categoryValue ='Egyptian';
  String countryValue ='Egyptian';
  var country;
  var RecipeTime;
  late User logeInUser;
  late String recipeName;
  late String downloadUrl;
  late String recipe;
  late var photo;
  late double long, lat;
  final picker = ImagePicker();

  @override
  void intistate() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      logeInUser = user;
    } catch (e) {
      print(e);
    }
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
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color(0xff174354),
          titleSpacing: 30,
          title: Text(
            "Add a new item",
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(5)),
                  Card(
                      child: (_image != null)
                          ? Image.file(
                              _image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            )
                          : Image(
                              image: AssetImage('images/add.png'),
                              width: 60,
                              height: 60,
                            )),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add Image',
                          style: TextStyle(
                            color: Colors.teal[600],
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Icon(
                          Icons.add_circle,
                          color: Colors.teal[500],
                        ),
                      ],
                    ),
                    onTap: getImage,
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: TextFormField(
                      validator: RequiredValidator(
                          errorText: 'this field is required'),
                      decoration: InputDecoration(
                        labelText: 'Enter the Name',
                        labelStyle: TextStyle(fontSize: 20),
                      ),
                      maxLines: 1,
                      onChanged: (val) {
                        RecipeName = val;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: TextFormField(
                      validator: RequiredValidator(
                          errorText: 'this field is required'),
                      decoration: InputDecoration(
                        labelText: 'Enter the Time',
                        labelStyle: TextStyle(fontSize: 20),
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        RecipeTime = val;
                      },
                    ),
                    //
                  ),
                  Container(
                      margin: EdgeInsets.all(20),
                      child: TextFormField(
                        validator: RequiredValidator(
                            errorText: 'this field is required'),
                        decoration: InputDecoration(
                          labelText: 'Enter the Ingredients',
                          labelStyle: TextStyle(fontSize: 20),
                        ),
                        maxLines: 7,
                        onChanged: (val) {
                          Ingredients = val;
                        },
                      )),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        validator: RequiredValidator(
                            errorText: 'this field is required'),
                        decoration: InputDecoration(
                          labelText: 'Enter the Recipe',
                          labelStyle: TextStyle(fontSize: 20),
                        ),
                        maxLines: 7,
                        onChanged: (val) {
                          Recipe = val;
                        },
                      )),
                  Container(
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: country,
                          hint: const Text('Enter the Country'),
                          icon: Icon(Icons.keyboard_arrow_down),
                          onChanged: (val) {
                            setState(() {
                              country = val;
                            });
                          },
                          items: <String>['Egyptian', 'English','arabic']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                        ),
                      )
                      ),
                  Container(
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: category,
                          hint: Text('Enter the Category'),
                          icon: Icon(Icons.keyboard_arrow_down),
                          onChanged: (val) {
                           setState(() {
                             category = val;
                           });
                          },
                          items: <String>['Egyptian', 'English','meat']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                        ),
                      )),
                  Padding(padding: EdgeInsets.all(10)),
                  ElevatedButton(
                    onPressed: () async {
                      (_formkey.currentState!.validate());
                      await uploadPic(context);
                      _firestore
                        ..collection("Items")
                            .doc(country)
                            .collection(country)
                            .doc(category)
                            .collection(category)
                            .add({
                          'url': downloadUrl,
                          'Recipe': Recipe,
                          'Ingredients': Ingredients,
                          'RecipeName': RecipeName,
                          'RecipeTime': RecipeTime,
                        });
                      // _firestore
                      //     .collection("Items").doc(country).collection(country)
                      //     .doc(category)
                      //     .set({'dummy': category});
                      // _firestore
                      //     .collection("Items")
                      //     .doc(country)
                      //     .set({'dummy': country});
                    },
                    child: Text('Upload Item'),
                    style: ElevatedButton.styleFrom(primary: Colors.teal),
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
