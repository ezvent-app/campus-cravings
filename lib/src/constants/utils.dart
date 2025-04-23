import 'package:flutter/material.dart';

showToast(String message, {BuildContext? context, Color? bgColor}) {
  if (context == null) return;

  final overlay = Overlay.of(context);
  if (overlay == null) return;

  final overlayEntry = OverlayEntry(
    builder:
        (context) => Positioned(
          top:
              MediaQuery.of(context).padding.top +
              10, // Adjust the top position
          left: 2,
          right: 2,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: bgColor ?? Colors.black87,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ),
        ),
  );

  overlay.insert(overlayEntry);

  // Remove the toast after a delay
  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
