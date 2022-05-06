import 'package:flutter/material.dart';
import 'package:untitled/filterCategory.dart';
import 'Recipes.dart';

class country_items extends StatelessWidget {
  final String title;

/*   final String id;

  final Color color; */
  //recieve title parameter
  country_items(this.title);

  void selectcountry(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => Filter(title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectcountry(context),
      borderRadius: BorderRadius.circular(15),
      child: Container(

        width: double.infinity,
        height: 70,
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.arrow_forward)
          ],
        ),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey, //New
                blurRadius: 25.0,
                offset: Offset(0, -10))
          ],
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
