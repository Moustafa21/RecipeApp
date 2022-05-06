import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  Future queryData(String qurryString) {
    return FirebaseFirestore.instance
        .collection('Egyptian')
        .where('Ingredients', isGreaterThanOrEqualTo: qurryString)
        .where('Ingredients', isLessThan: qurryString+'z')
        .get();
  }
}
