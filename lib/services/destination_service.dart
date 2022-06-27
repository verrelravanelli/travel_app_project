import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("destinations");

class DestinationService {
  static Stream<QuerySnapshot> fetchDataDestinations() {
    return collectionRef.snapshots();
  }
}
