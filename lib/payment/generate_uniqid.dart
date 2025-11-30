import 'dart:math';

String generateUniqueId() {
  final random = Random.secure();
  return random.nextInt(999999999).toString();
}