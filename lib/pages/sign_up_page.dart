import 'package:flutter/material.dart';
import 'package:proyek_ambw_kel15/models/APIModel.dart';
import 'package:proyek_ambw_kel15/services/api_service.dart';
import 'package:proyek_ambw_kel15/services/auth_service.dart';
import 'package:proyek_ambw_kel15/services/user_service.dart';
import '../theme.dart';
import '../widget/custom_text_form_field.dart';

// ******** BELOM ADA VALID EMAIL CHECKER!
class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final TextEditingController locationController =
      TextEditingController(text: '');

  List<APIModel> tempDataAPI = [];

  void ambilDataAPI() async {
    APISerivce apiService = APISerivce();
    Future<List<APIModel>> asiap;
    asiap = apiService.get(
      endpoint: '/v1/geo/cities',
      query: {
        "limit": "${1}",
        "countryIds": "ID",
        "namePrefix": locationController.text,
        "types": "CITY",
      },
    );
    tempDataAPI = await asiap;
  }

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

      Widget locationInput() {
        return CustomTextFormField(
          title: 'Location',
          hintText: 'Your Location',
          controller: locationController,
        );
      }

      Widget submitButton() {
        return Container(
          margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
          width: 200,
          height: 50,
          child: ElevatedButton(
              onPressed: () {
                if (emailController.text != "" &&
                    passwordController.text != "" &&
                    nameController.text != "" &&
                    locationController.text != "") {
                  //Panggil API Location Service
                  ambilDataAPI();
                  // APISerivce apiService = APISerivce();
                  // Future<List<APIModel>> asiap;
                  // asiap = apiService.get(
                  //   endpoint: '/v1/geo/cities',
                  //   query: {
                  //     "limit": "${1}",
                  //     "namePrefix": locationController.text,
                  //     "types": "CITY",
                  //   },
                  // );

                  // FutureBuilder<List<APIModel>>(
                  //     future: asiap,
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         print("masuk");
                  //         List<APIModel> dsData = snapshot.data!;
                  //         print(dsData[0].wikiDataId);
                  //         temp1 = dsData[0].wikiDataId;
                  //         temp2 = dsData[0].city;
                  //       }
                  //       return SizedBox();
                  //     });

                  Future.delayed(
                    Duration(seconds: 3),
                    () {
                      //Panggil Fungsi AuthService SignUp
                      AuthService.signUp(
                        email: emailController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        locationid: tempDataAPI[0].wikiDataId,
                        city: tempDataAPI[0].city,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Account Created"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      Future.delayed(
                        Duration(seconds: 2),
                        () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/main', (route) => false);
                        },
                      );
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Isi informasi dengan lengkap!"),
                    ),
                  );
                }
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
