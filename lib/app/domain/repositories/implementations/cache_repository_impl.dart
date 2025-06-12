import 'package:git_app/app/data/datasources/local_datasource/interfaces/cache_local_datasource.dart';
import 'package:git_app/app/data/models/models_export.dart';
import 'package:git_app/app/domain/repositories/interfaces/interfaces_export.dart';

class CacheRepositoryImpl implements CacheRepository {
  final CacheLocalDatasource cacheLocalDatasource;
  CacheRepositoryImpl({required this.cacheLocalDatasource});

  @override
  Future<void> clearAllCache() {
    try {
      return cacheLocalDatasource.clearAllCache();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUserCache(String username) async {
    try {
      final data = await cacheLocalDatasource.getUserCache(username);
      if (data == null) {
        return null;
      }
      return UserModel.fromMap(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future saveUserCache(String username, Map<String, dynamic> data) {
    try {
      return cacheLocalDatasource.setUserCache(username, data);
    } catch (e) {
      rethrow;
    }
  }
}
