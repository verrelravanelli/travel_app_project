import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyek_ambw_kel15/models/DestinationModel.dart';
import 'package:proyek_ambw_kel15/models/TransactionModel.dart';
import 'package:proyek_ambw_kel15/services/transaction_service.dart';
import 'package:proyek_ambw_kel15/theme.dart';
import 'package:proyek_ambw_kel15/widget/transaction_card.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late User user;

  @override
  void initState() {
    // TODO: implement initState
    user = FirebaseAuth.instance.currentUser!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: TransactionService.fetchDataHistoryTransaction(user.uid),
      builder: (context, snapshots) {
        if (snapshots.hasError) {
          return const Text("ERROR");
        } else if (snapshots.hasData || snapshots.data != null) {
          if (snapshots.data!.size == 0) {
            return Center(
              child: Text(
                "Anda Belum Memiliki Transaksi !",
                style: TextStyle(color: Colors.grey, fontWeight: bold),
              ),
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              DocumentSnapshot dsData = snapshots.data!.docs[index];
              TransactionModel dtTransaksi = TransactionModel(
                  banyakTraveler: dsData['banyakTraveler'],
                  destination: DestinationModel.fromJson(dsData['destination']),
                  price: dsData['price'],
                  tax: dsData['tax'],
                  grandTotal: dsData['grandTotal'],
                  selectedSeats: dsData['selectedSeats']);
              return TransactionCard(transaksi: dtTransaksi);
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 0,
            ),
            itemCount: snapshots.data!.docs.length,
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
          ),
        );
      },
    );
  }
}
