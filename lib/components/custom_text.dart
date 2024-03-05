import 'package:flutter/material.dart';

class EateryTitle extends StatelessWidget {
  const EateryTitle({super.key, required this.text, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w900, fontSize: 20),
    );
  }
}

class EaterySubTitle extends StatelessWidget {
  const EaterySubTitle({super.key, required this.text, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
    );
  }
}
