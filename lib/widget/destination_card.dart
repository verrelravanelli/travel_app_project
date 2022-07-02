// import 'package:airplane/models/destination_model.dart';
// import 'package:airplane/ui/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyek_ambw_kel15/models/DestinationModel.dart';
import 'package:proyek_ambw_kel15/pages/detail_page.dart';

import '../controllers/api_distance_controller.dart';
import '../models/UserModel.dart';
import '../theme.dart';

class DestinationCard extends StatelessWidget {
  final DestinationModel destinations;
  final UserModel currentUser;
  const DestinationCard(
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
        width: 180,
        height: 323,
        margin: EdgeInsets.only(
          left: defaultMargin,
        ),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: kWhiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 220,
              margin: EdgeInsets.only(
                bottom: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultRadius),
                image: DecorationImage(
                    image: NetworkImage(destinations.imageUrl),
                    fit: BoxFit.fill),
                color: Colors.black12,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 55,
                  height: 30,
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        defaultRadius,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.only(
                          right: 2,
                          top: 4,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/icon_star.png',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          destinations.rating.toString(),
                          style: blackTextStyle.copyWith(
                            fontWeight: medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destinations.name,
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: medium,
                    ),
                    overflow: TextOverflow.ellipsis,
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
          ],
        ),
      ),
    );
  }
}
