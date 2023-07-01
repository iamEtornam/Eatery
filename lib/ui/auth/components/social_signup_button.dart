import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialSignupButton extends StatelessWidget {
  const SocialSignupButton({
    Key? key,
    required this.onPressed,
    required this.logo,
    required this.label,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String logo;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(25.5),
      child: Container(
        height: 51,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.5),
            color: Theme.of(context).inputDecorationTheme.fillColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              logo,
              width: 17.01,
              height: 20.98,
            ),
            const SizedBox(
              width: 14.99,
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
