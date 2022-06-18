import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'loginSplash.dart';
import 'resetPassword.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String email, password;
  var _formkey = GlobalKey<FormState>();
  var _auth = FirebaseAuth.instance;
  bool visiblityPassword = true;
  bool spinner = false;
  var email_vaildator = MultiValidator([
    EmailValidator(errorText: 'البريد الالكتروني غير صحيح'),
    RequiredValidator(errorText: 'البريد الالكتروني مطلوب'),
  ]);
  var password_validator = MultiValidator([
    RequiredValidator(errorText: 'كلمة المرور مطلوبة'),
    MinLengthValidator(8, errorText: 'يجب ان لا تقل كلمة المرور عن 8 احرف'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'يجب ان تحتوي كلمة المرور على علامة مميزة واحدة على الاقل'),
  ]);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Builder(builder: (context) {
            return ModalProgressHUD(
              inAsyncCall: spinner,
              child: ListView(
                padding: EdgeInsets.all(25),
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Image(
                          image: AssetImage('assets/MealBoard.png'),
                          height: 150,
                          width: 150)),
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            validator: email_vaildator,
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
                            validator: password_validator,
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
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
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
                            try {
                              setState(() {
                                spinner = false;
                              });

                              if (email == 'admin@gmail.com') {
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginSplash()));
                              } else {
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginSplash()));
                              }
                            } catch (e) {
                              setState(() {
                                spinner = false;
                              });
                              if (e is FirebaseAuthException) {
                                if (e.code == 'user-not-found') {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('مستخدم غير موجود')));
                                } else if (e.code == 'wrong-password') {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('كلمة المرور خاطئة')));
                                }
                              }
                            }
                          }
                        }
                      },
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPassword()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 90),
                        child: Row(children: [
                          Text(
                            'هل نسيت كلمة المرور؟',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue[700],
                            ),
                          ),
                        ]),
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  Divider(
                      height: 2,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 70),
                    child: Row(children: [
                      Text(
                        'لا تملك حساب؟',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        },
                        child: Text(
                          'اشترك الان.  ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue[700],
                          ),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
