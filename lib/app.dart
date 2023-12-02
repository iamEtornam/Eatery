import 'package:bot_toast/bot_toast.dart';
import 'package:eatery/components/custom_theme.dart';
import 'package:eatery/router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Eatery',
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      theme: customLightTheme(context),
      darkTheme: customDarkTheme(context),
      themeMode: ThemeMode.light,
    );
  }
}
