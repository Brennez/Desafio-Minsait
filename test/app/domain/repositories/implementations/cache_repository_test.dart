import 'package:flutter_test/flutter_test.dart';
import 'package:git_app/app/domain/repositories/implementations/implementations_export.dart';
import 'package:mocktail/mocktail.dart';

import 'package:git_app/app/data/datasources/local_datasource/interfaces/cache_local_datasource.dart';
import 'package:git_app/app/data/models/user_model.dart';

class MockCacheLocalDatasource extends Mock implements CacheLocalDatasource {}

void main() {
  late CacheRepositoryImpl repository;
  late MockCacheLocalDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockCacheLocalDatasource();
    repository = CacheRepositoryImpl(cacheLocalDatasource: mockDatasource);
  });

  const username = 'john';
  final userData = {'login': 'john', 'id': 1};

  test('clearAllCache should calls datasource method', () async {
    when(() => mockDatasource.clearAllCache()).thenAnswer((_) async {});

    await repository.clearAllCache();

    verify(() => mockDatasource.clearAllCache()).called(1);
  });

  test('getUserCache should return a valid UserModel', () async {
    when(() => mockDatasource.getUserCache(username))
        .thenAnswer((_) async => userData);

    final result = await repository.getUserCache(username);

    expect(result, isA<UserModel>());
    expect(result!.username, equals('john'));
    expect(result.id, equals(1));
  });

  test('getUserCache should return null if there no are cache', () async {
    when(() => mockDatasource.getUserCache(username))
        .thenAnswer((_) async => null);

    final result = await repository.getUserCache(username);

    expect(result, isNull);
  });

  test('saveUserCache should calls datasource method', () async {
    when(() => mockDatasource.setUserCache(username, userData))
        .thenAnswer((_) async {});

    await repository.saveUserCache(username, userData);

    verify(() => mockDatasource.setUserCache(username, userData)).called(1);
  });
}
