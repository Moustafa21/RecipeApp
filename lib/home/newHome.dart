import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/home/itemCard2.dart';
import '../countryItems.dart';
import '../itemCards.dart';
import 'itemCard2.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> cats = ["American", "Pakistani"];

  //cats.shuffle();
  List<String> rtv = [];

  sfl() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Items")
          .doc(cats[0])
          .collection(cats[0])
          .doc("Meat")
          .collection("Meat")
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                return itemCards2(x['url'], x['RecipeName'], x['RecipeTime'],
                    x['Ingredients'], x['Recipe'], "", "", x.id);
              });
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  sfl1() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Items").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: 2,
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                return country_items(x.id,x['img']);
              });
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void initState() {
    cats.shuffle();
    //sfl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: false,
        title: Row(children: [
          Image(
            image: AssetImage('images/LogoGOLD.png'),
            fit: BoxFit.cover,
            height: 145,
            width: 145,
            alignment: Alignment.bottomRight,
          ),
          Padding(padding: EdgeInsets.all(80)),
          Text("الرئيسية"),
        ]),
        backgroundColor: Color(0xff174354),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 250.0,
                  child: sfl1(),
                ),
              ),
            ],
          ),
          SizedBox(height: 200,),
          Padding(padding: EdgeInsets.all(100)),
          Container(
            height: 200,
            child: sfl(),
            margin: EdgeInsets.only(top: 195),
          ),

        ],
      ),
    );
  }
/* Widget _ok(){
    return ListView.builder(
      itemCount: 3,
      itemExtent: 1000,
     itemBuilder: (BuildContext context, int index){
     return sfl();
     },
    );
  }*/
}
