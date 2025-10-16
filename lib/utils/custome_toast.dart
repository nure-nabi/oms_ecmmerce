import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomToast{
 static void showCustomRoast({
    required BuildContext context,
    required String message,
    required IconData icon,
    Color? backgroundColor = Colors.black87,
    Color? textColor = Colors.white,
    Color? iconColor = Colors.green,
    Duration duration = const Duration(seconds: 2),
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: iconColor),
                  const SizedBox(width: 8),
                  Text(
                    message,
                    style: GoogleFonts.poppins(
                      color: textColor
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(overlayEntry);
    Future.delayed(duration, overlayEntry.remove);
  }

  static void ScaffoldMessage({required BuildContext context,required String message,required Color? colors,int second =3}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colors,
        content: Text(message,style: GoogleFonts.poppins(),),
        duration: Duration(seconds: second), // optional
      ),
    );
  }
}