import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyek_ambw_kel15/models/TransactionModel.dart';

import '../models/UserModel.dart';

CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("users");

class TransactionService {
  static Stream<QuerySnapshot> fetchDataHistoryTransaction(String userUID) {
    return collectionReference
        .doc(userUID)
        .collection("transaction")
        .snapshots();
  }

  Future<void> tambahData(
      {required UserModel user, required TransactionModel transaksi}) async {
    DocumentReference docRef =
        collectionReference.doc(user.id).collection("transaction").doc();

    await docRef
        .set(transaksi.toJson())
        .whenComplete(() => print("Data Berhasil Ditambahkan"))
        .catchError((e) => print(e.toString()));
  }
}
