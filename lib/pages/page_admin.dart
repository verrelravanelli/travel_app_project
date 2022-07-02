import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyek_ambw_kel15/models/DestinationModel.dart';
import 'package:proyek_ambw_kel15/services/destination_service.dart';
import 'package:proyek_ambw_kel15/widget/custom_button.dart';

import '../theme.dart';
import '../widget/custom_text_form_field.dart';

class PageAdmin extends StatelessWidget {
  const PageAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController aboutcontroller =
        TextEditingController(text: '');
    final TextEditingController citycontroller =
        TextEditingController(text: '');
    final TextEditingController idcontroller = TextEditingController(text: '');
    final TextEditingController imageUrlcontroller =
        TextEditingController(text: '');
    final TextEditingController namecontroller =
        TextEditingController(text: '');
    final TextEditingController pricecontroller =
        TextEditingController(text: '');
    final TextEditingController ratingcontroller =
        TextEditingController(text: '');

    Widget inputSection() {
      Widget id() {
        return CustomTextFormField(
          title: 'Country ID',
          hintText: 'Country ID',
          controller: idcontroller,
        );
      }

      Widget city() {
        return CustomTextFormField(
          title: 'City',
          hintText: 'City',
          controller: citycontroller,
        );
      }

      Widget name() {
        return CustomTextFormField(
          title: 'Destination Name',
          hintText: 'Destination Name',
          controller: namecontroller,
        );
      }

      Widget about() {
        return CustomTextFormField(
          title: 'Destination About',
          hintText: 'About',
          controller: aboutcontroller,
        );
      }

      Widget imageUrl() {
        return CustomTextFormField(
          title: 'Destination ImageUrl',
          hintText: 'ImageUrl',
          controller: imageUrlcontroller,
        );
      }

      Widget price() {
        return CustomTextFormField(
          title: 'Destination price',
          hintText: 'price',
          controller: pricecontroller,
        );
      }

      Widget rating() {
        return CustomTextFormField(
          title: 'Destination Rating',
          hintText: 'rating',
          controller: ratingcontroller,
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
            id(),
            name(),
            city(),
            imageUrl(),
            about(),
            price(),
            rating(),
          ],
        ),
      );
    }

    Widget submitButton() {
      return CustomButton(
        buttonText: "Submit",
        onPressed: () {
          if (idcontroller.text != "" &&
              namecontroller.text != "" &&
              citycontroller.text != "" &&
              imageUrlcontroller.text != "" &&
              ratingcontroller.text != "" &&
              pricecontroller.text != "" &&
              aboutcontroller.text != "") {
            DestinationModel dtDestinasi = DestinationModel(
                id: idcontroller.text,
                name: namecontroller.text,
                city: citycontroller.text,
                imageUrl: imageUrlcontroller.text,
                rating: double.parse(ratingcontroller.text),
                price: int.parse(pricecontroller.text),
                about: aboutcontroller.text);

            DestinationService().tambahData(destination: dtDestinasi);

            Navigator.pushNamedAndRemoveUntil(
                context, '/main', (route) => false);
          } else {
            Fluttertoast.showToast(
                msg: "Input Informasi dengan lengkap!",
                gravity: ToastGravity.CENTER);
          }
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            inputSection(),
            submitButton(),
          ],
        ),
      ),
    );
  }
}
