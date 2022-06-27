import 'package:flutter/material.dart';
import 'package:proyek_ambw_kel15/services/auth_service.dart';
import '../theme.dart';
import '../widget/custom_button.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        buttonText: 'Sign Out',
        onPressed: () {
          AuthService.signOut();
          Navigator.pushNamedAndRemoveUntil(
              context, '/sign-in', (route) => false);
        },
        widthButton: 220,
      ),
    );
  }
}
