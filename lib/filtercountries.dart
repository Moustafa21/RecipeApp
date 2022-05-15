import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'countryItems.dart';

class FilterCountry extends StatelessWidget {
  FilterCountry({Key? key}) : super(key: key);
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: const Text("المطابخ",
        style: TextStyle(fontSize: 20),),
        backgroundColor: Color(0xff174354),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
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
                return country_items(x.id,x['img']);
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