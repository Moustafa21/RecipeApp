import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/Recipes.dart';
import 'package:untitled/chat.dart';
import 'package:untitled/filtercountries.dart';
import 'package:untitled/home/categories.dart';
import 'package:untitled/home/home.dart';
import 'package:untitled/login.dart';
import 'package:untitled/navigationBar.dart';
import 'package:untitled/search1/search.dart';
import 'package:untitled/search1/search1.dart';

import 'register.dart';
import 'package:untitled/login.dart';
import 'package:untitled/adminAdd.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: bottomNavBar()
    );
  }
}





