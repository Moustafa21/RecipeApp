import 'package:flutter/material.dart';
import 'Recipes.dart';
import 'filterCategory.dart';

class country_items extends StatelessWidget {
  final String title;
  final String imgurl;

/*   final String id;

  final Color color; */
  //recieve title parameter
  country_items(this.title,this.imgurl);

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
              Image.network(imgurl,height: 50,width: 50,),
              // Image(
              //   image: AssetImage(
              //       'images/kisspng-flag-of-the-united-states-national-flag-gadsden-fl-5aef0a166339d0.1825278315256151264064 (1)'),
              // ),
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
      ),
    );
  }
}
