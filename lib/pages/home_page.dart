import 'package:flutter/material.dart';

import '../theme.dart';
import '../widget/destination_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    'Howdy,\n${"John Doe"}',
                    style: blackTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Where to fly today?',
                    style: greyTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: light,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/foto_paris.jpg'),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget popularDestinations() {
      return Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                DestinationCard(
                  title: 'London',
                  subtitle: 'United Kingdom',
                  image: 'assets/foto_paris.jpg',
                )
              ]),
        ),
      );
    }

    Widget newDestinations() {
      return Container(
        margin: EdgeInsets.only(
          top: 15,
          left: defaultMargin,
          right: defaultMargin,
          bottom: 90,
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
                DestinationCard(
                  title: 'Paris',
                  subtitle: 'France',
                  image: 'assets/foto_paris.jpg',
                ),
                DestinationCard(
                  title: 'Rome',
                  subtitle: 'Italy',
                  image: 'assets/foto_paris.jpg',
                ),
                DestinationCard(
                  title: 'Berlin',
                  subtitle: 'Germany',
                  image: 'assets/foto_paris.jpg',
                ),
                DestinationCard(
                  title: 'Madrid',
                  subtitle: 'Spain',
                  image: 'assets/foto_paris.jpg',
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
