import 'package:flutter/material.dart';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';

class AppLoader {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context, {String message = 'Please wait.'}) {
    if (_overlayEntry != null) return;

    final overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (_) => Positioned.fill(
        child: IgnorePointer(
          ignoring: true,
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: AppColor.lightBlack,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColor.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      message,
                      style: const TextStyle(
                        color: AppColor.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
