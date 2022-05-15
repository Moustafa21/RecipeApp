import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String email,password,first_name,last_name,mobile;
  var _formkey=GlobalKey<FormState>();
  var _auth = FirebaseAuth.instance;
  bool spinner = false;
  var emailVaildator=MultiValidator([
    EmailValidator(errorText: 'Email not valid'),
    RequiredValidator(errorText: 'Email is required'),
  ]
  );
  var passwordValidator=MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character'),
  ]
  );
  var nameValidator=MultiValidator([RequiredValidator(errorText: 'Name is required')]);
  var mobileValidator=MultiValidator([
    RequiredValidator(errorText: 'Mobile is required'),
    MinLengthValidator(11, errorText: 'mobile is not valid'),
  ]);
  bool visiblityPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff174354),
        centerTitle: true,
        title: Text("انشاء حساب جديد",style: TextStyle(fontSize: 20),
        ),
      ),
      body:  Directionality(
        textDirection: TextDirection.rtl,
        child: Builder(
            builder: (context) {
              return ModalProgressHUD(
                inAsyncCall: spinner,
                child: ListView(
                  padding: EdgeInsets.all(15),
                  children: [
                    Form(
                        key: _formkey,
                        child: Column(
                          children:
                          [SizedBox(height: 40,),
                            Text('انشئ حساب جديد',style: TextStyle(fontSize: 20),),
                            SizedBox(height: 20,),
                            TextFormField(
                              validator: nameValidator,
                              onChanged: (val){
                                first_name =val ;
                              },
                              decoration: const InputDecoration(
                                hintText: "الاسم الاول",
                                labelText: "الاسم الاول",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              validator: nameValidator,
                              onChanged: (val){
                                last_name =val ;
                              },
                              decoration: const InputDecoration(
                                hintText: "الاسم الاخير",
                                labelText: "اللقب",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              validator: emailVaildator,
                              onChanged: (val){
                                email =val ;
                              },
                              decoration: const InputDecoration(
                                hintText: "البريد الالكتروني",
                                labelText: "البريد الالكتروني",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              validator: passwordValidator,
                              obscureText: visiblityPassword,
                              onChanged: (val){
                                password =val ;
                              },
                              decoration: InputDecoration(
                                hintText: "كلمة المرور",
                                labelText: "كلمة المرور",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      visiblityPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.indigo),
                                  onPressed: () {
                                    setState(() {
                                      //visiblityPassword? Icons.visibility : Icons.visibility_off;
                                      visiblityPassword = !visiblityPassword;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              validator: mobileValidator,
                              keyboardType: TextInputType.phone,
                              onChanged: (val){
                                mobile =val ;
                              },
                              decoration: const InputDecoration(
                                hintText: "رقم الهاتف",
                                labelText: "رقم الهاتف",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 40,),],
                        )
                    ),
                    FlatButton(
                        color: Colors.teal[500],
                        padding: EdgeInsets.all(20),
                        onPressed: ()async{
                          if(_formkey.currentState!.validate()) {
                            var connectivityResult = await (Connectivity()
                                .checkConnectivity());
                            if (connectivityResult != ConnectivityResult.mobile&&
                                connectivityResult != ConnectivityResult.wifi) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('لا يوجد اتصال بالانترنت')
                                  )
                              );
                            }
                            else {
                              setState(() {
                                spinner= true;
                              });
                              try{
                                await _auth.createUserWithEmailAndPassword(email: email, password: password);
                                FirebaseFirestore.instance.collection("users").doc(email).set({
                                  'firstName': first_name,
                                  'lastName' : last_name,
                                  'email' : email,
                                  'Mobile': mobile,
                                }
                                );
                                Navigator.push(context, MaterialPageRoute(builder : (context)=> Login()));
                                setState(() {
                                  spinner = false;
                                });
                              }
                              catch(e){
                                setState(() {
                                  spinner = false;
                                });
                                if(e is FirebaseAuthException){
                                  if(e.code =='email-already-in-use'){
                                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('البريد الالكتروني مستخدم بالفعل')
                                    )
                                    );
                                  }
                                }
                              }

                            }
                          }
                        },
                        child: Text
                          ('انشئ',
                          style: TextStyle(fontSize: 20),)
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){ Navigator.pop(context);},
                      child: Text(
                        'هل تملك حساب بالفعل؟',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,),
                      ),
                    )
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}