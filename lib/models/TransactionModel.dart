import 'package:proyek_ambw_kel15/models/DestinationModel.dart';

class TransactionModel {
  final int banyakTraveler;
  final DestinationModel destination;
  final int price;
  final int tax;
  final int grandTotal;
  final String selectedSeats;

  TransactionModel({
    required this.banyakTraveler,
    required this.destination,
    required this.price,
    required this.tax,
    required this.grandTotal,
    required this.selectedSeats,
  });

  Map<String, dynamic> toJson() {
    return {
      "banyakTraveler": banyakTraveler,
      "destination": destination.toJson(),
      "price": price,
      "tax": tax,
      "grandTotal": grandTotal,
      "selectedSeats": selectedSeats,
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      banyakTraveler: json['banyakTraveler'],
      destination: json['destination'],
      price: json['price'],
      tax: json['tax'],
      grandTotal: json['grandTotal'],
      selectedSeats: json['selectedSeats'],
    );
  }
}
