import 'package:eatery/index.dart';
import 'package:flutter/material.dart';

class CustomerView extends StatefulWidget {
  const CustomerView({super.key, required this.screenSize});

  final ScreenSize screenSize;

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customers',
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
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
