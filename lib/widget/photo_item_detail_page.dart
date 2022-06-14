import 'package:flutter/material.dart';

class PhotoItemDetailPage extends StatelessWidget {
  final String imageURL;

  const PhotoItemDetailPage({Key? key, required this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 16,
      ),
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            imageURL,
          ),
        ),
      ),
    );
  }
}
