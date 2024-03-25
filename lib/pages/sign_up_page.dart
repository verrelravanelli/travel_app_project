import 'package:flutter/material.dart';
import 'package:proyek_ambw_kel15/models/APIModel.dart';
import 'package:proyek_ambw_kel15/services/api_service.dart';
import 'package:proyek_ambw_kel15/services/auth_service.dart';
import '../theme.dart';
import '../widget/custom_text_form_field.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(text: '');
  final TextEditingController locationController = TextEditingController(text: '');

  List<APIModel> tempDataAPI = [];

  Future<void> ambilDataAPI() async {
    APISerivce apiService = APISerivce();
    List<APIModel> data = await apiService.get(
      endpoint: '/v1/geo/cities',
      query: {
        "limit": "${1}",
        "countryIds": "ID",
        "namePrefix": locationController.text,
        "types": "CITY",
      },
    );
    tempDataAPI = data;
  }

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(
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

      Widget locationInput() {
        return CustomTextFormField(
          title: 'Location',
          hintText: 'Your Location',
          controller: locationController,
        );
      }

      Widget submitButton() {
        return Container(
          margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          width: 200,
          height: 50,
          child: ElevatedButton(
              onPressed: () async {
                if (emailController.text != "" &&
                    passwordController.text != "" &&
                    nameController.text != "" &&
                    locationController.text != "") {
                  //Panggil API Location Service
                  await ambilDataAPI();

                  //Panggil Fungsi AuthService SignUp
                  await AuthService.signUp(
                    email: emailController.text,
                    password: passwordController.text,
                    name: nameController.text,
                    locationid: tempDataAPI[0].wikiDataId,
                    city: locationController.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Account Created"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  Future.delayed(
                    const Duration(seconds: 2),
                    () {
                      Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Isi informasi dengan lengkap!"),
                    ),
                  );
                }
              },
              child: const Text('Sign Up')),
        );
      }

      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Column(
          children: [
            nameInput(),
            emailInput(),
            passwordInput(),
            locationInput(),
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
          margin: const EdgeInsets.only(
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
