import 'package:flutter/material.dart';

import 'filterCategory.dart';

class country_items extends StatelessWidget {
  final String title;
  final String img;

  country_items(this.title, this.img);

  void selectcountry(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => Filter(title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: InkWell(
        onTap: () => selectcountry(context),
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: double.infinity,
          height: 70,
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(img, height: 40, width: 60, fit: BoxFit.cover),
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
                  color: Colors.grey, blurRadius: 25.0, offset: Offset(0, -10))
            ],
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
