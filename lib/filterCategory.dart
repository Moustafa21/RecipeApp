import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'categoryItems.dart';
class Filter extends StatelessWidget {
  final String country;
  Filter(this.country);
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff174354),
          title:  Text(country,
            style: TextStyle(fontSize: 20),)),
      body: StreamBuilder(
        stream: _firestore.collection("Items").doc(country).collection(country).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
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
                print(x.id);
                //Search(x.id);
                return category_items(x.id, country);
              },
              itemCount: snapshot.data!.docs.length,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}