import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_booking_app/utils/mytheme.dart';

class SocialLoginButton extends StatelessWidget {
  final Function() onGoogleClick;
  final Function() onFacebookClick;
  const SocialLoginButton(
      {super.key, required this.onFacebookClick, required this.onGoogleClick});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Material(
          color: MyTheme.blueLight,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(color: MyTheme.blueBorder, width: 0.2)),
          child: InkWell(
            onTap: onGoogleClick,
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/google.svg"),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Google",
                    style: TextStyle(
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        )),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Material(
          color: MyTheme.blueLight,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: const BorderSide(color: MyTheme.blueBorder, width: 0.2)),
          child: InkWell(
            onTap: onFacebookClick,
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/facebook.svg"),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Facebook",
                    style: TextStyle(
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        )),
      ],
    );
  }
}
