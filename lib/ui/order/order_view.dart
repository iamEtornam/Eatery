import 'package:eatery/index.dart';
import 'package:flutter/material.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key, required this.screenSize});

   final ScreenSize screenSize;

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
          .copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.black)
        ),
      ),
        body: const Scaffold(
        backgroundColor: Colors.green,
      ),
    );
  }
}