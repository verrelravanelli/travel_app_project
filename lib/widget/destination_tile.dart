// import 'package:airplane/models/destination_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyek_ambw_kel15/models/DestinationModel.dart';
import 'package:proyek_ambw_kel15/models/UserModel.dart';
import '../controllers/api_distance_controller.dart';
import '../pages/detail_page.dart';
import '../theme.dart';

// import '../detail_page.dart';

class DestinationTile extends StatelessWidget {
  final DestinationModel destinations;
  final UserModel currentUser;
  const DestinationTile(
    this.destinations,
    this.currentUser, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final APIDistanceController controller = Get.put(APIDistanceController());
    return GestureDetector(
      onTap: () {
        controller.destinationcity = destinations.city;
        controller.destinationid = destinations.id;
        controller.ambilDataAPI();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(destinations, currentUser),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 16,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(destinations.imageUrl),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destinations.name,
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    destinations.city,
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.only(
                    right: 2,
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
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
