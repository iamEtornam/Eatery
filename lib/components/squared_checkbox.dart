import 'package:flutter/material.dart';

class SquaredCheckbox extends StatefulWidget {
  const SquaredCheckbox(
      {super.key,
      required this.isChecked,
      required this.onTap,
      this.size = 20,
      required this.activeColor});

  final bool isChecked;
  final Function(bool value) onTap;
  final double size;
  final Color activeColor;

  @override
  State<SquaredCheckbox> createState() => _SquaredCheckboxState();
}

class _SquaredCheckboxState extends State<SquaredCheckbox> {
  bool? isChecked;

  @override
  void initState() {
    isChecked = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isChecked = !isChecked!);
        widget.onTap(isChecked!);
      },
      child: Material(
        color: isChecked!
            ? widget.activeColor
            : Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color.fromRGBO(200, 200, 200, 1))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 14,
            height: 14,
            child: isChecked!
                ? const Center(
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
