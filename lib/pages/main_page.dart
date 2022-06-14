import 'package:flutter/material.dart';
import 'package:proyek_ambw_kel15/pages/setting_page.dart';
import 'package:proyek_ambw_kel15/pages/transaction_page.dart';
import 'package:proyek_ambw_kel15/pages/wallet_page.dart';

import '../theme.dart';
import '../widget/custom_button_navigation.dart';
import 'home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return HomePage();
        case 1:
          return TransactionPage();
        case 2:
          return WalletPage();
        case 3:
          return SettingPage();
        default:
          return HomePage();
      }
    }

    Widget customBottomNavigation() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(
            bottom: 0,
            left: defaultMargin,
            right: defaultMargin,
          ),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButtonNavigationItem(
                index: 0,
                imageUrl: 'assets/icon_plane.png',
              ),
              CustomButtonNavigationItem(
                index: 1,
                imageUrl: 'assets/icon_plane.png',
              ),
              CustomButtonNavigationItem(
                index: 2,
                imageUrl: 'assets/icon_plane.png',
              ),
              CustomButtonNavigationItem(
                index: 3,
                imageUrl: 'assets/icon_plane.png',
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          buildContent(0),
          customBottomNavigation(),
        ],
      ),
    );
  }
}
