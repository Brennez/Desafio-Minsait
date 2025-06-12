import 'dart:convert';

import 'package:git_app/app/data/datasources/local_datasource/interfaces/interfaces_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheLocalDatasourceImpl implements CacheLocalDatasource {
  @override
  Future<void> clearAllCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final keys = prefs.getKeys().where((key) => key.startsWith('user_'));

      for (final key in keys) {
        await prefs.remove(key);
      }
    } catch (e) {
      throw Exception('Failed to clear cache: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserCache(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user_$username');

    if (jsonString == null) {
      return null;
    }

    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  @override
  Future setUserCache(String username, Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(data);
      await prefs.setString('user_$username', jsonString);
    } catch (e) {
      throw Exception('Failed to set user cache: $e');
    }
  }
}
