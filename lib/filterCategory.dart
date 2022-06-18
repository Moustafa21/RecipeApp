import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../categoryItems.dart';

class Filter extends StatelessWidget {
  final String country;
  final _firestore = FirebaseFirestore.instance;

  Filter(this.country);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff174354),
          title: Text(
            country,
            style: TextStyle(fontSize: 20),
          )),
      body: StreamBuilder(
        stream: _firestore
            .collection("Items")
            .doc(country)
            .collection(country)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.size == 0) {
            return Center(child: Text(".المطبخ فارغ، راسلنا لاضافة المزيد"));
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(25),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                return category_items(x.id, country, x['img']);
              },
              itemCount: snapshot.data!.docs.length,
            );
          }
        },
      ),
    );
  }
}
