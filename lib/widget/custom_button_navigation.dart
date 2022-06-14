import 'package:flutter/material.dart';
import '../theme.dart';

class CustomButtonNavigationItem extends StatelessWidget {
  final int index;
  final String imageUrl;

  const CustomButtonNavigationItem({
    Key? key,
    required this.index,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Image.asset(
            imageUrl,
            width: 24,
            height: 24,
          ),
          // Container(
          //   width: 24,
          //   height: 24,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(imageUrl),
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            width: 30,
            height: 2,
            decoration: BoxDecoration(),
          )
        ],
      ),
    );
  }
}
