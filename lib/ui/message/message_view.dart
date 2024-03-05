import 'package:eatery/index.dart';
import 'package:flutter/material.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key, required this.screenSize});

  final ScreenSize screenSize;

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
 
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
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
        backgroundColor: Colors.orange,
      ),
    );
  }
}
