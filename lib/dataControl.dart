import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  Future queryData(String qurryString) async {
    return FirebaseFirestore.instance
        .collection('Items')
        .doc("مصر")
        .collection("مصر")
        .doc("دجاج")
        .collection("دجاج")
        .where('RecipeName', isEqualTo: qurryString)
        .get();
  }
}
