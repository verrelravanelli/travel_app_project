import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("destinations");

CollectionReference collectionRef_2 =
    FirebaseFirestore.instance.collection("newthisyear");

class DestinationService {
  static Stream<QuerySnapshot> fetchDataDestinations() {
    return collectionRef.snapshots();
  }

  static Stream<QuerySnapshot> fetchDataDestinationsNewThisYear() {
    return collectionRef_2.snapshots();
  }
}
