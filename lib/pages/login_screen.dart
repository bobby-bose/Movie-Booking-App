import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:movie_booking_app/controller/auth_controller.dart';
import 'package:movie_booking_app/pages/signup_screen.dart';
import 'package:movie_booking_app/utils/mytheme.dart';
import 'package:movie_booking_app/utils/social_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      backgroundColor: MyTheme.splash,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: _size.height,
          width: _size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/splash_icon.svg"),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Welcome User",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
              Text(
                "Login to book your seat, I said its your seat",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding: const EdgeInsets.all(19),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                width: _size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login to your account",
                      style: TextStyle(
                        fontSize: 16,
                        color: MyTheme.splash,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Username",
                          hintStyle: const TextStyle(color: Colors.black45),
                          fillColor: MyTheme.greyColor,
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.black45),
                          fillColor: MyTheme.greyColor,
                          filled: true,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Get.defaultDialog(
                                title: "Forgot password",
                                content: TextFormField(
                                  controller: forgotEmailController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: "Email address",
                                    hintStyle:
                                        const TextStyle(color: Colors.black45),
                                    fillColor: MyTheme.greyColor,
                                    filled: true,
                                  ),
                                ),
                                radius: 10,
                                onWillPop: () {
                                  forgotEmailController.text = "";
                                  return Future.value(true);
                                },
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                confirm: ElevatedButton(
                                    onPressed: () {
                                      AuthController.instance.forgotPassword(
                                          forgotEmailController.text.trim());
                                      forgotEmailController.text = "";
                                      Get.back();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: MyTheme.splash,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        )),
                                    child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(22),
                                        child: Text(
                                          "Send reset email",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    )));
                          },
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        AuthController.instance.login(
                            emailController.text.trim(),
                            passwordController.text.trim());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.splash,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "Or",
                              style: TextStyle(color: Color(0xFFC1C1C1)),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: SocialLoginButton(
                          onFacebookClick: () {},
                          onGoogleClick: () {
                            AuthController.instance.googleLogin();
                          }),
                    ),
                  ],
                ),
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(text: "Don't have an account ? "),
                TextSpan(
                    text: "Sign up ",
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(() => const SignUpScreen());
                      }),
                const TextSpan(text: " here."),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
