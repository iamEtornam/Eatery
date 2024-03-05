import 'package:eatery/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomsheet extends StatelessWidget {
  const CustomBottomsheet({
    super.key,
    required this.child,
    this.onCloseAction,
    this.title,
    this.subtitle,
  });

  final Widget child;
  final VoidCallback? onCloseAction;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (title != null) ...{
                    Text(
                      title!,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                    )
                  },
                  const Spacer(),
                  if (onCloseAction != null) ...{
                    GestureDetector(
                        onTap: onCloseAction,
                        child: SvgPicture.asset(Vectors.backButtonCloseIcon))
                  }
                ],
              ),
              const SizedBox(height: 4),
              if (subtitle != null) ...{
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                )
              },
              child
            ],
          ),
        ),
      ),
    );
  }
}
