import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/UserModel.dart';
import '../services/user_service.dart';
import '../theme.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final TextEditingController topup = TextEditingController();
  late User user;
  late UserModel loggedUser =
      UserModel(id: "", email: "", name: "", balance: 0, locationid: "");

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

  void topUpBalance() async {
    var tempBalance = loggedUser.balance + int.parse(topup.text);
    UserModel dtUser = UserModel(
        id: loggedUser.id,
        email: loggedUser.email,
        name: loggedUser.name,
        balance: tempBalance,
        locationid: loggedUser.locationid);
    await UserService().topUpWallet(user: dtUser);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                      )
                    ],
                  ),
                ),
                // Container(
                //   width: 24,
                //   height: 24,
                //   margin: const EdgeInsets.only(right: 6),
                //   decoration: const BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage('assets/icon_plane.png'),
                //     ),
                //   ),
                // ),
                // // Text(
                // //   'Pay',
                // //   style: whiteTextStyle.copyWith(
                // //     fontSize: 16,
                // //     fontWeight: medium,
                // //   ),
                // // ),
                InkWell(
                  onTap: () {
                    topup.text = "";
                    showDialog(
                      useSafeArea: true,
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: kBackgroundColor,
                        title: Text("Top Up Balance"),
                        content: Container(
                          height: 75,
                          child: Column(
                            children: [
                              TextField(
                                controller: topup,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Input Jumlah Top Up",
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
                              setState(() {
                                topUpBalance();
                                getCurrentUser();
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
                    Icons.add_box,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 41,
            ),
            Text(
              'Balance',
              style: whiteTextStyle.copyWith(
                fontWeight: light,
              ),
            ),
            Text(
              NumberFormat.currency(
                locale: 'id',
                symbol: 'IDR ',
                decimalDigits: 0,
              ).format(
                loggedUser.balance,
              ),
              style: whiteTextStyle.copyWith(
                fontSize: 26,
                fontWeight: medium,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
