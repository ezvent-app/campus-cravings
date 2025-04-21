import 'package:flutter/material.dart';

class ToastUtils {
  static void showToast(
    String message, {
    BuildContext? context,
    Color? bgColor,
  }) {
    if (context == null) return;

    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: bgColor ?? Colors.black87,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
