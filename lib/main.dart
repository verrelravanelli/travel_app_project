import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyek_ambw_kel15/pages/bonus_page.dart';
import 'package:proyek_ambw_kel15/pages/get_started_page.dart';
import 'package:proyek_ambw_kel15/pages/main_page.dart';
import 'package:proyek_ambw_kel15/pages/page_admin.dart';
import 'package:proyek_ambw_kel15/pages/sign_in_page.dart';
import 'package:proyek_ambw_kel15/pages/sign_up_page.dart';
import 'package:proyek_ambw_kel15/pages/splash_page.dart';
import 'package:proyek_ambw_kel15/pages/success_checkout_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/success': (context) => const SuccessCheckoutPage(),
        '/page-admin': (context) => const PageAdmin(),
      },
    );
  }
}
