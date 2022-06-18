import 'package:flutter/material.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigatetoLogin();
  }

  navigatetoLogin() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(80.0),
            child: Container(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('assets/MealBoard.png'),
                height: 445,
                width: 445,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              "MEALBOARD",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ]),
      ),
    );
  }
}
