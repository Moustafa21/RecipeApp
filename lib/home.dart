import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Details.dart';
import '../countryItems.dart';
import 'itemCard2.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> cnts = [
    'مصر',
    'لبنان',
    'ايطاليا',
    'المغرب',
    'تونس',
    'سوريا',
    'فرنسا',
    'العراق',
  ];
  List<String> cats = [
    'دجاج',
    'لحوم',
    'مأكولات بحرية',
    'مقبلات',
    'معجنات',
    'حلويات'
  ];

  items(int i) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Items")
          .doc(cnts[i])
          .collection(cnts[i])
          .doc(cats[i])
          .collection(cats[i])
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.data?.size == 0) {
          return Center(child: Text(".الوصفات غير متوفرة"));
        } else {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                return itemCards2(x['url'], x['RecipeName'], x['RecipeTime'],
                    x['Ingredients'], x['Recipe'], cnts[i], cats[i], x.id);
              });
        }
      },
    );
  }

  countries() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Items").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.data?.size == 0) {
          return Center(child: Text(".المطابخ غير متوفرة"));
        } else {
          return ListView.builder(
              itemCount: 2,
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                return country_items(x.id, x['img']);
              });
        }
      },
    );
  }

  @override
  void initState() {
    cats.shuffle();
    cnts.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Row(children: [
            Image(
              image: AssetImage('assets/MealBoard.png'),
              fit: BoxFit.cover,
              height: 50,
              width: 50,
            ),
            Container(
                margin: EdgeInsets.only(left: 60),
                child: Text(
                  "MEALBOARD",
                  style: TextStyle(fontWeight: FontWeight.w800),
                )),
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
                    height: 200.0,
                    child: countries(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 200,
            ),
            Padding(padding: EdgeInsets.all(100)),
            Container(
              height: 200,
              child: items(0),
              margin: EdgeInsets.only(top: 195),
            ),
            Container(
              margin: EdgeInsets.only(top: 375),
              child: Divider(
                color: Colors.black26,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
            ),
            Container(
              height: 200,
              child: items(1),
              margin: EdgeInsets.only(top: 395),
            ),
          ],
        ),
      ),
    );
  }
}
