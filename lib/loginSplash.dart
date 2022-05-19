import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'adminNavBar.dart';
import 'navigationBar.dart';

class LoginSplash extends StatefulWidget {
  const LoginSplash({Key? key}) : super(key: key);

  @override
  State<LoginSplash> createState() => _LoginSplashState();
}

class _LoginSplashState extends State<LoginSplash> {
  bool spinner = true;
  var _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    navigatetoHome();
  }

  navigatetoHome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => _auth.currentUser?.email == 'admin@gmail.com'
                ? adminNavBar()
                : bottomNavBar()));
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: spinner,
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Text("...جاري التحميل"),
        ),
      ),
    );
  }
}