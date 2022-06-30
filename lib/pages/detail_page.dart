import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:proyek_ambw_kel15/models/UserModel.dart';

import '../controllers/api_distance_controller.dart';
import '../controllers/pilih_seat_controller.dart';
import '../models/APIModel.dart';
import '../models/DestinationModel.dart';
import '../services/api_service.dart';
import '../theme.dart';
import '../widget/custom_button.dart';
import '../widget/interest_item_detail_page.dart';
import '../widget/photo_item_detail_page.dart';
import 'choose_seat_page.dart';

class DetailPage extends StatelessWidget {
  final DestinationModel destinations;
  final UserModel currentUser;
  DetailPage(this.destinations, this.currentUser, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PilihSeatController controller = Get.put(PilihSeatController());
    final APIDistanceController controllerAPI =
        Get.put(APIDistanceController());
    Widget backgroundImage() {
      return Container(
        width: double.infinity,
        height: 450,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(destinations.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget customShadow() {
      return Container(
        margin: EdgeInsets.only(
          top: 236,
        ),
        width: double.infinity,
        height: 214,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              kWhiteColor.withOpacity(0),
              Colors.black.withOpacity(0.95),
            ],
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          children: [
            // Note : Title
            Container(
              margin: EdgeInsets.only(
                top: 256,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          destinations.name,
                          overflow: TextOverflow.ellipsis,
                          style: whiteTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          destinations.city,
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: light,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        margin: EdgeInsets.only(
                          right: 4,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/icon_star.png',
                            ),
                          ),
                        ),
                      ),
                      Text(
                        destinations.rating.toString(),
                        style: whiteTextStyle.copyWith(
                          fontWeight: bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Note : Description
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 30,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Note : ABOUT
                  Text(
                    'About',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    destinations.about,
                    style: blackTextStyle.copyWith(
                      fontWeight: regular,
                      height: 2,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Note : From City - To City
                  Row(
                    children: [
                      Text(
                        'From City : ',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          currentUser.city,
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(style: BorderStyle.solid),
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  Row(
                    children: [
                      Text(
                        'To City : ',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          destinations.city,
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(style: BorderStyle.solid),
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Note : Price & Book Button
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 30,
              ),
              width: double.infinity,
              child: Row(
                children: [
                  // Price
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'IDR ',
                            decimalDigits: 0,
                          ).format(
                            destinations.price,
                          ),
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: medium,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'per orang',
                          style: greyTextStyle.copyWith(fontWeight: light),
                        ),
                      ],
                    ),
                  ),

                  // Book Button
                  CustomButton(
                    buttonText: 'Book Now',
                    onPressed: () {
                      controller.resetSeat();
                      controllerAPI.ambilDataAPIDistance();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChooseSeatPage(
                            destinasi: destinations,
                            currentUser: currentUser,
                          ),
                        ),
                      );
                    },
                    widthButton: 170,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        children: [
          Stack(
            children: [
              backgroundImage(),
              customShadow(),
              content(),
            ],
          ),
        ],
      ),
    );
  }
}
