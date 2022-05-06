import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/countryItems.dart';

class FilterCountry extends StatelessWidget {
  FilterCountry({Key? key}) : super(key: key);
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Filter")),
      body: StreamBuilder(
        stream: _firestore.collection("Items").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(25),
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                print(x.id);
                //Search(x.id);
                return country_items(x.id);
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