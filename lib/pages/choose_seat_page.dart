import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:proyek_ambw_kel15/controllers/pilih_seat_controller.dart';
import 'package:proyek_ambw_kel15/models/DestinationModel.dart';
import 'package:proyek_ambw_kel15/models/TransactionModel.dart';
import 'package:proyek_ambw_kel15/models/UserModel.dart';

import '../theme.dart';
import '../widget/custom_button.dart';
import '../widget/seat_item.dart';
import '../widget/seat_status_widget.dart';
import 'checkout_page.dart';
import 'package:get/get.dart';

class ChooseSeatPage extends GetView<PilihSeatController> {
  final DestinationModel destinasi;
  final UserModel currentUser;
  const ChooseSeatPage({
    Key? key,
    required this.destinasi,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PilihSeatController controller = Get.put(PilihSeatController());

    Widget title() {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: Text(
          'Select Your\nFavorite Seat',
          style: blackTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget seatStatus() {
      return Container(
        margin: EdgeInsets.only(
          top: 15,
        ),
        child: SeatStatusWidget(),
      );
    }

    Widget selectSeat() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: kWhiteColor,
        ),
        child: Column(
          children: [
            // Note : Seat Indicator
            Container(
              height: 280,
              child: Obx(
                () => GridView.builder(
                  padding: EdgeInsets.all(4),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount:
                      controller.seat[controller.indexKursi.value].length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => controller.SelectSeat(index),
                    child: Container(
                      child: Center(
                        child: Text(
                          controller.seat[controller.indexKursi.value][index]
                              ["id"],
                          style: TextStyle(
                            fontWeight: bold,
                            color: controller.seat[controller.indexKursi.value]
                                        [index]["status"] ==
                                    "selected"
                                ? kWhiteColor
                                : kBlackColor,
                          ),
                        ),
                      ),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kPrimaryColor,
                        ),
                        color: controller.seat[controller.indexKursi.value]
                                    [index]["status"] ==
                                "available"
                            ? Colors.grey[300]
                            : controller.seat[controller.indexKursi.value]
                                        [index]["status"] ==
                                    "selected"
                                ? kPrimaryColor
                                : kGreyColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Note : YOUR SEAT
            Container(
              margin: EdgeInsets.only(
                top: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Seat',
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                    ),
                  ),
                  Obx(
                    () => Flexible(
                      child: Text(
                        controller.userSelectedSeat.join(', '),
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Note : Total
            Container(
              margin: EdgeInsets.only(
                top: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                    ),
                  ),
                  Obx(
                    () => Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'IDR ',
                        decimalDigits: 0,
                      ).format(
                        controller.userSelectedSeat.length * destinasi.price,
                      ),
                      style: purpleTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget checkoutButton() {
      return CustomButton(
        buttonText: 'Continue to Checkout',
        onPressed: () {
          int price = controller.userSelectedSeat.length * destinasi.price;
          double temp = price + (price * 0.1);
          int grandtotal = temp.round();
          TransactionModel dtTransaksi = TransactionModel(
            banyakTraveler: controller.userSelectedSeat.length,
            destination: destinasi,
            price: price,
            tax: 10,
            grandTotal: grandtotal,
            selectedSeats: controller.userSelectedSeat.join(', '),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutPage(
                currentUser: currentUser,
                transaksi: dtTransaksi,
              ),
            ),
          );
        },
        margin: EdgeInsets.only(
          top: 30,
          bottom: 46,
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          title(),
          seatStatus(),
          selectSeat(),
          checkoutButton(),
        ],
      ),
    );
  }
}
