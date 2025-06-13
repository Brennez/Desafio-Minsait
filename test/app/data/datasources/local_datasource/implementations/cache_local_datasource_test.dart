import 'package:flutter_test/flutter_test.dart';
import 'package:git_app/app/data/datasources/local_datasource/implementations/implementations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  late CacheLocalDatasourceImpl datasource;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    datasource = CacheLocalDatasourceImpl();
  });

  test('should be save data in cache', () async {
    final username = 'john_doe';
    final userData = {'username': 'John', 'data': {}};

    await datasource.setUserCache(username, userData);

    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('user_$username');

    expect(jsonString, isNotNull);
    expect(jsonDecode(jsonString!), equals(userData));
  });

  test('should be return data from cache if exists', () async {
    final username = 'john_doe';
    final userData = {'username': 'John', 'data': {}};

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_$username', jsonEncode(userData));

    final result = await datasource.getUserCache(username);

    expect(result, isNotNull);
    expect(result, equals(userData));
  });

  test('should be return null if not exists cache', () async {
    final result = await datasource.getUserCache('user_inexistente');

    expect(result, isNull);
  });

  test('should be clear all cache with prefix user_', () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_a', '{"data": "A"}');
    await prefs.setString('user_b', '{"data": "B"}');
    await prefs.setString('outra_chave', '{"data": "X"}');

    await datasource.clearAllCache();

    expect(prefs.getString('user_a'), isNull);
    expect(prefs.getString('user_b'), isNull);
    expect(prefs.getString('outra_chave'), isNotNull);
  });
}
