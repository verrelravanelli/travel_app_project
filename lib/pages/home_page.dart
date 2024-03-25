import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyek_ambw_kel15/models/DestinationModel.dart';
import 'package:proyek_ambw_kel15/models/UserModel.dart';
import 'package:proyek_ambw_kel15/services/destination_service.dart';
import 'package:proyek_ambw_kel15/services/user_service.dart';
import 'package:proyek_ambw_kel15/widget/destination_tile.dart';

import '../controllers/api_distance_controller.dart';
import '../theme.dart';
import '../widget/destination_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final APIDistanceController controller = Get.put(APIDistanceController());
  late UserModel loggedUser = UserModel(id: "", email: "", name: "", balance: 0, locationid: "", city: "");
  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    loggedUser = await UserService().getUserByID(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      controller.userlocationid = loggedUser.locationid;
      controller.userCity = loggedUser.city;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          right: defaultMargin,
          left: defaultMargin,
          top: 20,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome,\n${loggedUser.name}',
                    style: blackTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Where to travel today?',
                    style: greyTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: light,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget popularDestinations() {
      return Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        height: 323,
        child: StreamBuilder<QuerySnapshot>(
          stream: DestinationService.fetchDataDestinations(),
          builder: (context, snapshots) {
            if (snapshots.hasError) {
              return const Text("ERROR");
            } else if (snapshots.hasData || snapshots.data != null) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  DocumentSnapshot dsData = snapshots.data!.docs[index];
                  DestinationModel destinationData = DestinationModel(
                    id: dsData['id'],
                    name: dsData['name'],
                    city: dsData['city'],
                    imageUrl: dsData['imageUrl'],
                    rating: double.parse(dsData['rating'].toString()),
                    price: dsData['price'],
                    about: dsData['about'],
                  );
                  return DestinationCard(destinationData, loggedUser);
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
        ),
      );
    }

    Widget newDestinations() {
      return Container(
        margin: EdgeInsets.only(
          top: 15,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New This Year',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                  ),
                  height: 350,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: DestinationService.fetchDataDestinationsNewThisYear(),
                    builder: (context, snapshots) {
                      if (snapshots.hasError) {
                        return const Text("ERROR");
                      } else if (snapshots.hasData || snapshots.data != null) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            DocumentSnapshot dsData = snapshots.data!.docs[index];
                            DestinationModel destinationData = DestinationModel(
                              id: dsData['id'],
                              name: dsData['name'],
                              city: dsData['city'],
                              imageUrl: dsData['imageUrl'],
                              rating: double.parse(dsData['rating'].toString()),
                              price: dsData['price'],
                              about: dsData['about'],
                            );
                            return DestinationTile(destinationData, loggedUser);
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
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return ListView(
      children: [
        header(),
        popularDestinations(),
        newDestinations(),
      ],
    );
  }
}
