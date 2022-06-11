import 'package:flutter/material.dart';
import 'package:proyek_ambw_kel15/pages/sign_in_page.dart';
import 'package:proyek_ambw_kel15/pages/sign_up_page.dart';

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
        '/': (context) => SignUpPage(),
        '/sign-in': (context) => SignInPage(),
      },
    );
  }
}
