import 'package:flutter/services.dart';

class NativeAarBridge {
  static const MethodChannel _channel = MethodChannel('com.example'); // Must match Android channel name

  // Example: Call a method from the AAR
  static Future<String> connectToDevice() async {
    try {
      final String result = await _channel.invokeMethod('connectToDevice');
      return result;
    } on PlatformException catch (e) {
      return "Failed: ${e.message}";
    }
  }

// Add more methods as needed...
}