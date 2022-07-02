import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyek_ambw_kel15/models/DestinationModel.dart';

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

  Future<void> tambahData({required DestinationModel destination}) async {
    DocumentReference docRef = collectionRef.doc();

    await docRef
        .set(destination.toJson())
        .whenComplete(() => print("Data Berhasil Ditambahkan"))
        .catchError((e) => print(e.toString()));
  }
}
