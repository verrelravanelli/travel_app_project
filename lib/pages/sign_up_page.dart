import 'package:flutter/material.dart';
import 'package:proyek_ambw_kel15/services/auth_service.dart';
import 'package:proyek_ambw_kel15/services/user_service.dart';
import '../theme.dart';
import '../widget/custom_text_form_field.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Text(
          'Join us and travel\nacross the world',
          style: blackTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget inputSection() {
      Widget nameInput() {
        return CustomTextFormField(
          title: 'Full Name',
          hintText: 'Your full name',
          controller: nameController,
        );
      }

      Widget emailInput() {
        return CustomTextFormField(
          title: 'Email Address',
          hintText: 'Your email address',
          controller: emailController,
        );
      }

      Widget passwordInput() {
        return CustomTextFormField(
          title: 'Password',
          hintText: 'Your password',
          obsecureText: true,
          controller: passwordController,
        );
      }

      Widget submitButton() {
        return Container(
          margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
          width: 200,
          height: 50,
          child: ElevatedButton(
              onPressed: () {
                //Panggil Fungsi AuthService SignUp
                AuthService.signUp(
                    email: emailController.text,
                    password: passwordController.text,
                    name: nameController.text);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Account Created"),
                  ),
                );
                Future.delayed(
                  Duration(seconds: 3),
                  () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/sign-in', (route) => false);
                  },
                );
              },
              child: Text('Sign Up')),
        );
      }

      return Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          children: [
            nameInput(),
            emailInput(),
            passwordInput(),
            submitButton(),
          ],
        ),
      );
    }

    Widget signInButton() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/sign-in');
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            top: 20,
            bottom: 20,
          ),
          child: Text(
            'Have an account? Sign In',
            style: greyTextStyle.copyWith(
              fontSize: 16,
              fontWeight: light,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          children: [
            title(),
            inputSection(),
            signInButton(),
          ],
        ),
      ),
    );
  }
}
