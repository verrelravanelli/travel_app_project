import 'package:flutter/material.dart';
import 'package:proyek_ambw_kel15/pages/bonus_page.dart';
import 'package:proyek_ambw_kel15/pages/get_started_page.dart';
import 'package:proyek_ambw_kel15/pages/main_page.dart';
import 'package:proyek_ambw_kel15/pages/sign_in_page.dart';
import 'package:proyek_ambw_kel15/pages/sign_up_page.dart';
import 'package:proyek_ambw_kel15/pages/splash_page.dart';
import 'package:proyek_ambw_kel15/pages/success_checkout_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/get-started': (context) => const GetStartedPage(),
        '/sign-up': (context) => SignUpPage(),
        '/sign-in': (context) => SignInPage(),
        '/bonus': (context) => const BonusPage(),
        '/main': (context) => const MainPage(),
        '/success': (context) => SuccessCheckoutPage(),
      },
    );
  }
}
