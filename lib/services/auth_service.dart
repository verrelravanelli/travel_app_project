import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyek_ambw_kel15/models/UserModel.dart';
import 'package:proyek_ambw_kel15/services/user_service.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class AuthService {
  static Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        balance: 0,
      );

      await UserService().tambahData(user: user);
    } catch (e) {
      throw e;
    }
  }

  static Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserModel user =
          await UserService().getUserByID(userCredential.user!.uid);
      return user;
    } catch (e) {
      throw e;
    }
  }

  static Future<void> signOut() async {
    await auth
        .signOut()
        .whenComplete(() => print("Berhasil Logout"))
        .catchError((e) => print(e.toString()));
  }
}
