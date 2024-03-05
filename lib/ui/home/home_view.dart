import 'package:eatery/index.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.screenSize});
  final ScreenSize screenSize;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black),
        ),
      ),
      body: const Scaffold(
        backgroundColor: Colors.red,
      ),
    );
  }
}
