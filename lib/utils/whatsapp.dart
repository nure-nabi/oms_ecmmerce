import 'package:url_launcher/url_launcher.dart';

class WhatsAppLauncher {
  static Future<void> openChat({
    required String phone,
    String? message,
    bool tryWebFallback = true,
  }) async {
    try {
      // Clean phone number (keep only digits and +)
      final cleanedPhone = phone.replaceAll(RegExp(r'[^0-9+]'), '');

      // Try different URL schemes in sequence
      final urlsToTry = [
        _buildWhatsAppUrl(cleanedPhone, message, useNativeScheme: true),
        _buildWhatsAppUrl(cleanedPhone, message, useNativeScheme: false),
        if (tryWebFallback) Uri.parse('https://web.whatsapp.com'),
      ];

      for (final url in urlsToTry) {
        if (url == null) continue;

        try {
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
            return;
          }
        } catch (e) {
          print('Failed to launch URL $url: $e');
          continue;
        }
      }

      throw 'Could not launch WhatsApp. Please install WhatsApp or try again later.';
    } catch (e) {
      print('Error in WhatsAppLauncher: $e');
      rethrow;
    }
  }

  static Uri? _buildWhatsAppUrl(
      String phone,
      String? message, {
        required bool useNativeScheme,
      }) {
    try {
      final scheme = useNativeScheme ? 'whatsapp' : 'https';
      final host = useNativeScheme ? 'send' : 'wa.me';
      final params = {
        'phone': phone,
        if (message != null) 'text': message,
      };

      return Uri(
        scheme: scheme,
        host: host,
        queryParameters: params,
      );
    } catch (e) {
      print('Error building WhatsApp URL: $e');
      return null;
    }
  }
}