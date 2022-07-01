import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:proyek_ambw_kel15/services/auth_service.dart';
import '../controllers/api_distance_controller.dart';
import '../models/UserModel.dart';
import '../services/user_service.dart';
import '../theme.dart';
import '../widget/custom_button.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final APIDistanceController controller = Get.put(APIDistanceController());
  final TextEditingController nama = TextEditingController();
  final TextEditingController city = TextEditingController();

  late User user;
  late UserModel loggedUser = UserModel(
      id: "", email: "", name: "", balance: 0, locationid: "", city: "");
  @override
  void initState() {
    // TODO: implement initState
    user = FirebaseAuth.instance.currentUser!;
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    loggedUser = await UserService().getUserByID(user.uid);
    setState(() {});
  }

  void updateProfile() async {
    UserModel dtUser = UserModel(
      id: loggedUser.id,
      email: loggedUser.email,
      name: nama.text,
      balance: loggedUser.balance,
      locationid: controller.tempDataAPIEditProfile[0].wikiDataId,
      city: city.text,
    );
    await UserService().editProfile(user: dtUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                width: 300,
                height: 211,
                padding: EdgeInsets.all(defaultMargin),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(defaultRadius),
                  ),
                  color: kPrimaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: light,
                                ),
                              ),
                              Text(
                                loggedUser.name,
                                style: whiteTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: medium,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 3.0,
                                style: BorderStyle.solid,
                                color: Colors.white),
                          ),
                          child: InkWell(
                            onTap: () {
                              nama.text = loggedUser.name;
                              city.text = loggedUser.city;
                              showDialog(
                                useSafeArea: true,
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: kBackgroundColor,
                                  title: Text("Edit Profile"),
                                  content: Container(
                                    height: 150,
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: nama,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Edit Nama",
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                          controller: city,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Edit City",
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("CANCEL"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        controller.kotabaru = city.text;
                                        setState(() {
                                          controller.ambilDataAPIEditProfile();
                                          Future.delayed(
                                            Duration(seconds: 2),
                                            () {
                                              updateProfile();
                                              Fluttertoast.showToast(
                                                  msg: "Berhasil Edit Profile");
                                              getCurrentUser();
                                            },
                                          );
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Icon(
                              Icons.mode_edit_outlined,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'City',
                      style: whiteTextStyle.copyWith(
                        fontWeight: light,
                      ),
                    ),
                    Text(
                      loggedUser.city,
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: medium,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: CustomButton(
                buttonText: 'Sign Out',
                onPressed: () {
                  AuthService.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/sign-in', (route) => false);
                },
                widthButton: 220,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
