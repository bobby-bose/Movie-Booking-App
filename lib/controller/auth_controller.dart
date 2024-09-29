import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_booking_app/pages/home_screen.dart';
import 'package:movie_booking_app/pages/login_screen.dart';
import 'package:movie_booking_app/utils/mytheme.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  bool isLoging = false;
  User? get user => _user.value;
  late Rx<User?> _user;

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.authStateChanges());
    ever(_user, loginRedirect);
  }

  loginRedirect(User? user) {
    Timer(Duration(seconds: isLoging ? 0 : 2), () {
      if (user == null) {
        isLoging = false;
        update();
        Get.offAll(() => const LoginScreen());
      } else {
        isLoging = true;
        update();
        Get.offAll(() => const HomeScreen());
      }
    });
  }

  void registerUser(email, password) async {
    try {
      isLoging = true;
      update();
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      //define error
      getErrorSnachBar("Account creation failed", e);
    }
  }

  void login(email, password) async {
    try {
      isLoging = true;
      update();
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      //define error
      getErrorSnachBar("Login failed", e);
    }
  }

  void googleLogin() async {
    final GoogleSignIn googleSignIn =
        GoogleSignIn(); //an error occured part 3 last session
    isLoging = true;
    update();
    try {
      googleSignIn.disconnect();
    } catch (e) {}
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication? googleAuth =
            await googleSignInAccount.authentication;
        final Credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await auth.signInWithCredential(Credential);
      }
    } on FirebaseAuthException catch (e) {
      getErrorSnachBar("Google login failed", e);
    }
  }

  void forgotPassword(email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      getSuccessSnackBar("Reset emsil send successfully. Check email");
    } on FirebaseAuthException catch (e) {
      getErrorSnachBar("Error", e);
    }
  }

  getErrorSnachBar(String message, _) {
    Get.snackbar("Error", "$message\n${_.message}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: MyTheme.redBorder,
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10));
  }

  getSuccessSnackBar(String message) {
    Get.snackbar("Success", message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: MyTheme.redBorder,
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10));
  }

  void signOut() async {
    await auth.signOut();
  }
}
