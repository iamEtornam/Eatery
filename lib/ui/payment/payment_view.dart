import 'package:eatery/index.dart';
import 'package:flutter/material.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key, required this.screenSize});

  final ScreenSize screenSize;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payments',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.black)),
      ),
      body: const Scaffold(
        backgroundColor: Colors.purple,
      ),
    );
  }
}
