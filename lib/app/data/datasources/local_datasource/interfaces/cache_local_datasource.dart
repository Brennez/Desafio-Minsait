abstract class CacheLocalDatasource {
  Future<dynamic> setUserCache(String username, Map<String, dynamic> data);

  Future<Map<String, dynamic>?> getUserCache(String username);

  Future<void> clearAllCache();
}
