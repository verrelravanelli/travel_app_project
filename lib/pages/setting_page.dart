import 'package:flutter/material.dart';
import '../theme.dart';
import '../widget/custom_button.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        buttonText: 'Sign Out',
        onPressed: () {},
        widthButton: 220,
      ),
    );
  }
}
