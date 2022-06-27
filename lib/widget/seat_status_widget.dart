import 'package:flutter/material.dart';

import '../theme.dart';

class SeatStatusWidget extends StatelessWidget {
  const SeatStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Note : Available
        Container(
          width: 16,
          height: 16,
          margin: EdgeInsets.only(
            right: 6,
          ),
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(
          //       'assets/icon_available.png',
          //     ),
          //   ),
          // ),
        ),
        Text(
          'Available',
          style: blackTextStyle,
        ),
        // Note : Selected
        Container(
          width: 16,
          height: 16,
          margin: EdgeInsets.only(
            left: 10,
            right: 6,
          ),
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(
          //       'assets/icon_selected.png',
          //     ),
          //   ),
          // ),
        ),
        Text(
          'Selected',
          style: blackTextStyle,
        ),
        // Note : Unavailable
        Container(
          width: 16,
          height: 16,
          margin: EdgeInsets.only(
            left: 10,
            right: 6,
          ),
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(
          //       'assets/icon_unavailable.png',
          //     ),
          //   ),
          // ),
        ),
        Text(
          'Unavailable',
          style: blackTextStyle,
        ),
      ],
    );
  }
}
