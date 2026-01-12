import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

void showFlashSaleAlert(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: _buildFlashSaleContent(context),
      ),
    ),
  );
}

Widget _buildFlashSaleContent(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Flash Sale Header
      Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
            ),
            child: ClipRRect(
                borderRadius:BorderRadius.all(Radius.circular(5)),
                child: Image.asset('assets/icons/gargicon.png')),
          ),
          Positioned(
            left: 10,
              top: 10,
              child: InkWell(
                onTap: ()=> Navigator.pop(context),
                  child: Icon(FontAwesome.circle_xmark,color: Colors.black,)))
        ],
      ),

      const SizedBox(height: 20),



      // Close Button
      SizedBox(

        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // Fill color
            foregroundColor: Colors.white, // Text color
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            side: const BorderSide(
              color: Colors.white, // Border color
              width: 1.0, // Border thickness
            ),
          ),
          child: const Text('CLOSE'),
        ),
      ),
    ],
  );
}

Widget _buildOfferCard({
  required String title,
  required String subtitle,
  required Color color,
  required IconData icon,
  required String price,
}) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.black87),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              price,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildBottomNavItem(IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 24, color: Colors.red),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black87,
        ),
      ),
    ],
  );
}