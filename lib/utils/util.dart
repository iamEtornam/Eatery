import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

extension ColorXs on Color {
  ColorFilter get asSvgColor => ColorFilter.mode(this, BlendMode.srcIn);
}

void developerLog(dynamic message) {
  log('$message', name: 'Developer');
}

enum ToastificationType {
  info,
  success,
  warning,
  error,
}

showAlert(BuildContext context,
    {String title = 'Information',
    required String message,
    ToastificationType? alertType = ToastificationType.info}) {
  return toastification.show(
    context: context,
    style: ToastificationStyle.fillColored,
    foregroundColor: Colors.white,
    progressBarTheme: const ProgressIndicatorThemeData(
      color: Colors.white,
    ),
    autoCloseDuration: const Duration(seconds: 5),
    title: Text(title),
    description: Text(message),
    alignment: Alignment.topCenter,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    icon: Icon(
        alertType == ToastificationType.error
            ? Icons.error_outline_rounded
            : alertType == ToastificationType.success
                ? Icons.check_circle_outline_rounded
                : alertType == ToastificationType.warning
                    ? Icons.warning_outlined
                    : Icons.info_outline_rounded,
        color: Colors.white),
    backgroundColor: alertType == ToastificationType.error
        ? Colors.red
        : alertType == ToastificationType.success
            ? Colors.green
            : alertType == ToastificationType.warning
                ? Colors.amber
                : Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: false,
    closeButtonShowType: CloseButtonShowType.always,
    closeOnClick: true,
    pauseOnHover: true,
    dragToClose: true,
    callbacks: ToastificationCallbacks(
      onTap: (toastItem) => developerLog('Toast ${toastItem.id} tapped'),
      onCloseButtonTap: (toastItem) =>
          developerLog('Toast ${toastItem.id} close button tapped'),
      onAutoCompleteCompleted: (toastItem) =>
          developerLog('Toast ${toastItem.id} auto complete completed'),
      onDismissed: (toastItem) =>
          developerLog('Toast ${toastItem.id} dismissed'),
    ),
  );
}
