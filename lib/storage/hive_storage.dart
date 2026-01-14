
import 'package:hive/hive.dart';

import '../constant/values.dart';

enum UserKey {
  offerActive,
  offerImage,

}

class HiveData {
  HiveData(this.key, this.value);

  final String key;
  final String value;

  @override
  String toString() {
    return '{$key: $value}';
  }
}

class HiveStorage {
  static final Box _userPrefBox = Hive.box(HiveDatabase.user_prefs.name);

  static Future<void> add(String key, String value) async {
    await _userPrefBox.put(key, value);
  }

  static String get(String key) {
    return _userPrefBox.get(key, defaultValue: '');
  }

  static Map<String, String> getAll() {
    return _userPrefBox.toMap() as Map<String, String>;
  }

  static Future<void> delete(String key) async {
    await _userPrefBox.delete(key);
  }

  static bool hasPermission(String key) {
    return _userPrefBox.get(key, defaultValue: false);
  }


  static Future<void> setPermission(String key, bool value) async {
    await _userPrefBox.put(key, value);
  }

}


