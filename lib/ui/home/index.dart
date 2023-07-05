import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

class IndexView extends StatefulWidget {
  const IndexView({super.key});

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
        selectedIndex: index,
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: (context) {
          return const ColoredBox(color: Colors.red);
        },
        largeBody: (context) {
          return const ColoredBox(color: Colors.blue);
        },
        smallBody: (context) {
          return const ColoredBox(color: Colors.green);
        },
        secondaryBody: (context) {
          return const ColoredBox(color: Colors.orange);
        },
        largeSecondaryBody: (context) {
          return const ColoredBox(color: Colors.amber);
        },
        smallSecondaryBody: (context) {
          return const ColoredBox(color: Colors.indigo);
        },
        onSelectedIndexChange: (p0) {
          setState(() {
            index = p0;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_max_outlined),
            label: 'home',
            tooltip: 'home',
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            icon: Icon(Icons.pie_chart_outline),
            label: 'Orders',
            tooltip: 'Orders',
            selectedIcon: Icon(Icons.pie_chart),
          ),
          NavigationDestination(
            icon: Icon(Icons.person_2_outlined),
            label: 'Customers',
            tooltip: 'Customers',
            selectedIcon: Icon(Icons.person_2),
          ),
          NavigationDestination(
            icon: Icon(Icons.message_outlined),
            label: 'Messages',
            tooltip: 'Messages',
            selectedIcon: Icon(Icons.message),
          ),
          NavigationDestination(
            icon: Icon(Icons.money),
            label: 'Payments',
            tooltip: 'Payments',
            selectedIcon: Icon(Icons.money),
          )
        ]);
  }
}
