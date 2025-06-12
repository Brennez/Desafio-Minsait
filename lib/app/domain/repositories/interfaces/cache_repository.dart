import 'package:git_app/app/data/models/models_export.dart';

abstract class CacheRepository {
  Future<dynamic> saveUserCache(String username, Map<String, dynamic> data);

  Future<UserModel?> getUserCache(String username);

  Future<void> clearAllCache();
}
