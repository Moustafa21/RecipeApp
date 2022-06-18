import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  var durationValidator = MultiValidator([
    RequiredValidator(errorText: 'خانة مطلوبة'),
    PatternValidator(r'(^(?:[0-9]))', errorText: 'ادخل رقم')
  ]);

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var _formkey = GlobalKey<FormState>();
  bool showSpinner = false;
  var _image;
  var Ingredients;
  var RecipeName;
  var Recipe;
  var category;
  String categoryValue = '';
  String countryValue = '';
  var country;
  var RecipeTime;
  late User logeInUser;
  late String downloadUrl;
  final picker = ImagePicker();
  var ctrl1 = TextEditingController();
  var ctrl2 = TextEditingController();
  var ctrl3 = TextEditingController();
  var ctrl4 = TextEditingController();

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
    return WillPopScope(
      onWillPop: () async => false,
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Color(0xff174354),
            titleSpacing: 30,
            title: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "أضف وصفة جديدة",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Form(
              key: _formkey,
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(5)),
                      Card(
                          color: Colors.grey[200],
                          child: (_image != null)
                              ? Image.file(
                                  _image,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.fill,
                                )
                              : Image(
                                  image: AssetImage('assets/upload.png'),
                                  width: 100,
                                  height: 100,
                                )),
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'أضف صورة',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.teal[600],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Icon(
                              Icons.add_circle,
                              color: Colors.teal[500],
                              size: 20,
                            ),
                          ],
                        ),
                        onTap: getImage,
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: TextFormField(
                          controller: ctrl1,
                          validator:
                              RequiredValidator(errorText: 'خانة مطلوبة'),
                          decoration: InputDecoration(
                            labelText: 'اسم الوصفة',
                            labelStyle: TextStyle(fontSize: 20),
                            border: OutlineInputBorder(),
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
                          controller: ctrl2,
                          validator: durationValidator,
                          decoration: InputDecoration(
                            labelText: 'مدة التحضير',
                            labelStyle: TextStyle(fontSize: 20),
                            border: OutlineInputBorder(),
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
                            controller: ctrl3,
                            validator:
                                RequiredValidator(errorText: 'خانة مطلوبة'),
                            decoration: InputDecoration(
                              labelText: 'المكونات',
                              labelStyle: TextStyle(fontSize: 20),
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 7,
                            onChanged: (val) {
                              Ingredients = val;
                            },
                          )),
                      Container(
                          margin: EdgeInsets.all(20),
                          child: TextFormField(
                            controller: ctrl4,
                            validator:
                                RequiredValidator(errorText: 'خانة مطلوبة'),
                            decoration: InputDecoration(
                              labelText: 'خطوات التحضير',
                              labelStyle: TextStyle(fontSize: 20),
                              border: OutlineInputBorder(),
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
                              menuMaxHeight: 300,
                              isExpanded: true,
                              value: country,
                              hint: const Text('اختر البلد'),
                              icon: Icon(Icons.keyboard_arrow_down),
                              onChanged: (val) {
                                setState(() {
                                  country = val;
                                });
                              },
                              items: <String>[
                                'مصر',
                                'امريكا',
                                'ايطاليا',
                                'يونان',
                                'تركيا',
                                'اسبانيا',
                                'مكسيك',
                                'لبنان',
                                'العراق',
                                'تايلاند',
                                'المانيا',
                                'المغرب',
                                'باكستان',
                                'تونس',
                                'سوريا',
                                'فرنسا',
                                'كوريا',
                                'اليابان',
                                'الهند',
                                'ماليزيا',
                                'ليبيا',
                                'الجزائر',
                                'الاردن',
                                'الصين',
                                'هولاندا',
                                'سويسرا',
                                'دنمارك',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.all(20),
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child: DropdownButton<String>(
                              menuMaxHeight: 200,
                              isExpanded: true,
                              value: category,
                              hint: Text('اختر القسم'),
                              icon: Icon(Icons.keyboard_arrow_down),
                              onChanged: (val) {
                                setState(() {
                                  category = val;
                                });
                              },
                              items: <String>[
                                'دجاج',
                                'لحوم',
                                'خضار',
                                'مأكولات بحرية',
                                'مقبلات',
                                'معجنات',
                                'حلويات'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                            ),
                          )),
                      Padding(padding: EdgeInsets.all(15)),
                      ButtonTheme(
                        height: 100,
                        minWidth: 200,
                        child: ElevatedButton(
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
                                  })
                                  .then((value) => ctrl1.clear())
                                  .then((value) => ctrl2.clear())
                                  .then((value) => ctrl3.clear())
                                  .then((value) => ctrl4.clear())
                                  .then((value) => Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        "تم اضافة ${RecipeName}",
                                        style: TextStyle(fontSize: 10),
                                      ))));
                          },
                          child: Text('اضف الوصفة',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(primary: Colors.teal),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
