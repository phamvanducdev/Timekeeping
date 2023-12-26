// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:timekeeping/data/models/user.dart';

class SharedPref {
  static SharedPreferences? _sharedPreferences;

  static Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setCurrentUser(User user) async {
    _sharedPreferences?.setString(
      SharedPrefKeyStore.USER_LOGGED.keyStore,
      jsonEncode(user.toMap()),
    );
  }

  static Future<User?> getCurrentUser() async {
    var userString = _sharedPreferences?.getString(SharedPrefKeyStore.USER_LOGGED.keyStore);
    if (userString == null) return null;
    return User.fromMap(jsonDecode(userString));
  }

  static Future<void> clear() async {
    _sharedPreferences?.clear();
  }
}

enum SharedPrefKeyStore {
  USER_LOGGED('user-logged');

  final String keyStore;
  const SharedPrefKeyStore(this.keyStore);
}
