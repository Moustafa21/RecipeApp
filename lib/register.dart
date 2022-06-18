import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String email, password, first_name, last_name, mobile;
  var _formkey = GlobalKey<FormState>();
  var _auth = FirebaseAuth.instance;
  bool spinner = false;
  var emailVaildator = MultiValidator([
    EmailValidator(errorText: 'البريد الالكتروني غير صحيح'),
    RequiredValidator(errorText: 'البريد الالكتروني مطلوب'),
  ]);
  var passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'كلمة المرور مطلوبة'),
    MinLengthValidator(8, errorText: 'يجب ان لا تقل كلمة المرور عن 8 احرف'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'كلمة المرور يجب ان تحتوي على علامة مميزة واحدة على الاقل'),
  ]);
  var nameValidator =
      MultiValidator([RequiredValidator(errorText: 'الاسم مطلوب')]);
  var mobileValidator = MultiValidator([
    RequiredValidator(errorText: 'رقم الهاتف مطلوب'),
    MinLengthValidator(11, errorText: 'رقم الهاتف غير صحيح'),
  ]);
  bool visiblityPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Builder(builder: (context) {
          return ModalProgressHUD(
            inAsyncCall: spinner,
            child: ListView(
              padding: EdgeInsets.all(25),
              children: [
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'انشئ حسابك',
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          validator: nameValidator,
                          onChanged: (val) {
                            first_name = val;
                          },
                          decoration: const InputDecoration(
                            hintText: "الاسم بالكامل",
                            labelText: "الاسم بالكامل",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: emailVaildator,
                          onChanged: (val) {
                            email = val;
                          },
                          decoration: const InputDecoration(
                            hintText: "البريد الالكتروني",
                            labelText: "البريد الالكتروني",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          validator: passwordValidator,
                          obscureText: visiblityPassword,
                          onChanged: (val) {
                            password = val;
                          },
                          decoration: InputDecoration(
                            hintText: "كلمة المرور",
                            labelText: "كلمة المرور",
                            suffixIcon: IconButton(
                              icon: Icon(
                                  visiblityPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.teal[500]),
                              onPressed: () {
                                setState(() {
                                  visiblityPassword = !visiblityPassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    )),
                FlatButton(
                    color: Colors.teal[600],
                    padding: EdgeInsets.all(10),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult != ConnectivityResult.mobile &&
                            connectivityResult != ConnectivityResult.wifi) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('لا يوجد اتصال بالانترنت')));
                        } else {
                          setState(() {
                            spinner = true;
                          });
                          try {
                            await _auth
                                .createUserWithEmailAndPassword(
                                    email: email, password: password)
                                .then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login())));
                            setState(() {
                              spinner = false;
                            });
                          } catch (e) {
                            setState(() {
                              spinner = false;
                            });
                            if (e is FirebaseAuthException) {
                              if (e.code == 'email-already-in-use') {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'البريد الالكتروني مستخدم بالفعل')));
                              }
                            }
                          }
                        }
                      }
                    },
                    child: Text(
                      'انشاء حساب',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                SizedBox(
                  height: 80,
                ),
                Divider(
                    height: 2, indent: 10, endIndent: 10, color: Colors.black),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.only(right: 40),
                  child: Row(children: [
                    Text(
                      'هل تملك حساب بالفعل؟',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'سجل الدخول.  ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue[700],
                        ),
                      ),
                    )
                  ]),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
