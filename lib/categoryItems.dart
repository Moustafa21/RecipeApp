import 'package:flutter/material.dart';
import 'Recipes.dart';

class category_items extends StatelessWidget {
  final String title;
  final String country;

  /*   final String id;

  final Color color; */
  //recieve title parameter
  category_items(this.title, this.country);

  void selectCategory(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => Recipes(title, country)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Center(
            child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )),
        decoration: BoxDecoration(
          color: Colors.teal[100],
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
