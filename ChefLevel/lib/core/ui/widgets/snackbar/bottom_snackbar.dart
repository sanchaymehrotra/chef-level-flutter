import 'package:flutter/material.dart';
import 'bottom_snackbar_widget.dart';

class BottomSnackBar {
  static void show(
      BuildContext context, {
        required String message,
        Color backgroundColor = Colors.black87,
        IconData? icon,
        int duration = 3,
      }) {
    final overlay = Overlay.of(context);

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return BottomSnackBarWidget(
          message: message,
          backgroundColor: backgroundColor,
          icon: icon,
          duration: duration,
          onDismissed: () => overlayEntry.remove(),
        );
      },
    );

    overlay.insert(overlayEntry);
  }


}
