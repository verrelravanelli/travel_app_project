import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyek_ambw_kel15/models/UserModel.dart';
import 'package:proyek_ambw_kel15/services/auth_service.dart';
import '../theme.dart';
import '../widget/custom_button.dart';
import '../widget/custom_text_form_field.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  late UserModel tmpUser = UserModel(
      id: "", email: "", name: "", balance: 0, locationid: "", city: "");

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: EdgeInsets.only(
          top: 20,
        ),
        child: Text(
          'Sign In with your\nexisting account',
          style: blackTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget inputSection() {
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
        return CustomButton(
          buttonText: 'Sign In',
          widthButton: 220,
          margin: EdgeInsets.only(
            top: 20,
          ),
          onPressed: () {
            signIn(context);
          },
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
            emailInput(),
            passwordInput(),
            submitButton(),
          ],
        ),
      );
    }

    Widget tacButton() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/sign-up');
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            top: 50,
            bottom: 73,
          ),
          child: Text(
            'Don\'t Have an account? Sign Up',
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
            tacButton(),
          ],
        ),
      ),
    );
  }

  void signIn(context) async {
    if (emailController.text == "" && passwordController.text == "") {
      Fluttertoast.showToast(msg: "Input Email & Password!");
    } else if (emailController.text == "") {
      Fluttertoast.showToast(msg: "Input Email");
    } else if (passwordController.text == "") {
      Fluttertoast.showToast(msg: "Input Password!");
    } else {
      tmpUser = await AuthService.signIn(
          email: emailController.text, password: passwordController.text);
      if (tmpUser.id != "") {
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      }
    }
  }
}
