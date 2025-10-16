import 'package:flutter/material.dart';

class LoadingOverlay {
  static OverlayEntry _overlay = OverlayEntry(builder: (context) => const SizedBox());

  static void show(BuildContext context) {
    _overlay = OverlayEntry(
      builder: (context) => ColoredBox(
        color: Colors.black.withAlpha(80),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlay);
  }

  static void hide() {
    _overlay.remove();
  }
}
