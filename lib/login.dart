import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:untitled/chat.dart';
import 'package:untitled/filtercountries.dart';
import 'package:untitled/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:untitled/resetPassword.dart';
import 'adminAdd.dart';
import 'package:untitled/Recipes.dart';
import 'package:untitled/itemCards.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late String email, password;
  var _formkey = GlobalKey<FormState>();
  var _auth = FirebaseAuth.instance;
  bool spinner = false;
  var email_vaildator = MultiValidator([
    EmailValidator(errorText: 'Email not valid'),
    RequiredValidator(errorText: 'Email is required'),
  ]);
  var password_validator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character'),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color(0xff174354),
        titleSpacing: 30,
        title: Text(
          "Login",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Builder(builder: (context) {
        return ModalProgressHUD(
          inAsyncCall: spinner,
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        validator: email_vaildator,
                        onChanged: (val) {
                          email = val;
                        },
                        decoration: const InputDecoration(
                          hintText: "Email",
                          labelText: "email",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        validator: password_validator,
                        obscureText: true,
                        onChanged: (val) {
                          password = val;
                        },
                        decoration: const InputDecoration(
                          hintText: "Password",
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  )
              ),

              FlatButton(
                  color: Colors.teal[300],
                  padding: EdgeInsets.all(20),
                  onPressed: () async {
                    (_formkey.currentState!.validate());
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult != ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('no internet connection')));
                    } else {
                      try {
                        setState(() {
                          spinner = false;
                        });
                        if (email == 'admin@gmail.com') {
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Add()));
                        } else {
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FilterCountry()));
                        }
                      } catch (e) {
                        setState(() {
                          spinner = false;
                        });
                        if (e is FirebaseAuthException) {
                          if (e.code == 'user-not-found') {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('user not found')));
                          } else if (e.code == 'wrong-password') {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('wrong pasword')));
                          }
                        }
                      }
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Register()),
                    );
                  },
                  child: Row(
                    children: const [
                      Text(
                        'Don\'t have account?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black38,
                        ),
                      ),
                      Text(
                        'sign up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ResetPassword()),
                    );
                  },
                  child: Row(
                    children: const [
                      Text(
                        'Forgot password?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                        ),
                      ),

                    ],
                  )
              ),
            ],
          ),
        );
      }),
    );
  }
}
