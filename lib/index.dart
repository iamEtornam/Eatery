import 'dart:developer';

import 'package:eatery/ui/customer/customer_view.dart';
import 'package:eatery/ui/home/home_view.dart';
import 'package:eatery/ui/message/message_view.dart';
import 'package:eatery/ui/order/order_view.dart';
import 'package:eatery/ui/payment/payment_view.dart';
import 'package:eatery/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

enum ScreenSize { large, small, largeSecondary, smallSecondary }

class IndexView extends StatefulWidget {
  const IndexView({super.key, this.currentIndex, this.detail});

  final int? currentIndex;
  final Widget? detail;

  @override
  State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      index = widget.currentIndex ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
        selectedIndex: index,
        bodyRatio: widget.detail != null ? 0.7 : 1,
        body: (context) {
          log(index.toString(), name: 'body');
          return [
            const HomeView(screenSize: ScreenSize.small),
            const OrderView(screenSize: ScreenSize.small),
            const CustomerView(screenSize: ScreenSize.small),
            const MessageView(screenSize: ScreenSize.small),
            const PaymentView(screenSize: ScreenSize.small),
          ][index];
        },
        largeBody: (context) {
          log(index.toString(), name: 'largeBody');

          return [
            const HomeView(screenSize: ScreenSize.large),
            const OrderView(screenSize: ScreenSize.large),
            const CustomerView(screenSize: ScreenSize.large),
            const MessageView(screenSize: ScreenSize.large),
            const PaymentView(screenSize: ScreenSize.large),
          ][index];
        },
        smallBody: (context) {
          log(index.toString(), name: 'smallBody');

          return [
            const HomeView(screenSize: ScreenSize.small),
            const OrderView(screenSize: ScreenSize.small),
            const CustomerView(screenSize: ScreenSize.small),
            const MessageView(screenSize: ScreenSize.small),
            const PaymentView(screenSize: ScreenSize.small),
          ][index];
        },
        // secondaryBody: (context) {
        //   log(index.toString(), name: 'secondaryBody');

        //   return [
        //     const HomeView(screenSize: ScreenSize.smallSecondary),
        //     const OrderView(screenSize: ScreenSize.smallSecondary),
        //     const CustomerView(screenSize: ScreenSize.smallSecondary),
        //     const MessageView(screenSize: ScreenSize.smallSecondary),
        //     const PaymentView(screenSize: ScreenSize.smallSecondary),
        //   ][index];
        // },
        // largeSecondaryBody: (context) {
        //   log(index.toString(), name: 'largeSecondaryBody');

        //   return [
        //     const HomeView(screenSize: ScreenSize.largeSecondary),
        //     const OrderView(screenSize: ScreenSize.largeSecondary),
        //     const CustomerView(screenSize: ScreenSize.largeSecondary),
        //     const MessageView(screenSize: ScreenSize.largeSecondary),
        //     const PaymentView(screenSize: ScreenSize.largeSecondary),
        //   ][index];
        // },
        // smallSecondaryBody: (context) {
        //   log(index.toString(), name: 'smallSecondaryBody');

        //   return [
        //     const HomeView(screenSize: ScreenSize.smallSecondary),
        //     const OrderView(screenSize: ScreenSize.smallSecondary),
        //     const CustomerView(screenSize: ScreenSize.smallSecondary),
        //     const MessageView(screenSize: ScreenSize.smallSecondary),
        //     const PaymentView(screenSize: ScreenSize.smallSecondary),
        //   ][index];
        // },
        onSelectedIndexChange: (p0) {
          setState(() {
            index = p0;
          });
          developerLog(index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_max_outlined),
            label: 'Home',
            tooltip: 'Home',
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
