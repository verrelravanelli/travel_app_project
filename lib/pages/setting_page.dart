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
  final TextEditingController password = TextEditingController();
  late UserModel loggedUser = UserModel(id: "", email: "", name: "", balance: 0, locationid: "", city: "");

  var pwadmin = "1234";
  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    loggedUser = await UserService().getUserByID(FirebaseAuth.instance.currentUser!.uid);
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
            const SizedBox(
              height: 10,
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
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            border: Border.all(width: 3.0, style: BorderStyle.solid, color: Colors.white),
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
                                  title: const Text("Edit Profile"),
                                  content: Container(
                                    height: 150,
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: nama,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Edit Nama",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                          controller: city,
                                          decoration: const InputDecoration(
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
                                      child: const Text("CANCEL"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        controller.kotabaru = city.text;
                                        setState(() {
                                          controller.ambilDataAPIEditProfile();
                                          Future.delayed(
                                            const Duration(seconds: 2),
                                            () {
                                              updateProfile();
                                              Fluttertoast.showToast(msg: "Berhasil Edit Profile");
                                              getCurrentUser();
                                            },
                                          );
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.mode_edit_outlined,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CustomButton(
                buttonText: 'Sign Out',
                onPressed: () {
                  AuthService.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
                },
                widthButton: 220,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: CustomButton(
                buttonText: 'Admin',
                onPressed: () {
                  showDialog(
                    useSafeArea: true,
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: kBackgroundColor,
                      title: const Text("Input Password"),
                      content: Container(
                        height: 75,
                        child: Column(
                          children: [
                            TextField(
                              obscureText: true,
                              controller: password,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Input Password",
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("CANCEL"),
                        ),
                        TextButton(
                          onPressed: () {
                            if (password.text == pwadmin) {
                              print("masuk");
                              Navigator.pushNamed(context, '/page-admin');
                            } else {
                              Fluttertoast.showToast(msg: "Password Salah!", gravity: ToastGravity.CENTER);
                            }
                            //Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
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
