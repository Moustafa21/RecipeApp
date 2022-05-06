import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Searching extends StatefulWidget {
  const Searching({Key? key}) : super(key: key);

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'search',
            ),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != '' && name != null)
            ? FirebaseFirestore.instance
                .collection('Items')
                .doc('لبناني')
                .collection('Recipes')
                .doc('Recipes')
                .collection('لبناني')
                .where('RecipeName', isEqualTo: [name]).snapshots()
            : FirebaseFirestore.instance
                .collection('Items')
                .doc('لبناني')
                .collection('Recipes')
                .doc('Recipes')
                .collection('لبناني')
                .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              data['RecipeName'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            leading: CircleAvatar(
                              child: Image.network(
                                data['url'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                              radius: 40,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          )
                        ],
                      ),
                    );
                  });
        },
      ),
    );
  }
}
