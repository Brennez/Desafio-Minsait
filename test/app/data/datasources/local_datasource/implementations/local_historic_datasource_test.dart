import 'package:flutter_test/flutter_test.dart';
import 'package:git_app/app/data/datasources/local_datasource/implementations/implementations.dart';
import 'package:hive/hive.dart';
import 'dart:io';

void main() {
  late LocalHistoricDatasourceImpl datasource;
  late Directory tempDir;
  late Box box;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);

    box = await Hive.openBox('searchs');
    datasource = LocalHistoricDatasourceImpl();
  });

  tearDown(() async {
    await box.clear();
  });

  tearDownAll(() async {
    await Hive.close();
    await tempDir.delete(recursive: true);
  });

  test('should return an empty map when the box is empty at start', () {
    box.clear();

    final result = datasource.getPastSearchs();

    expect(result, isEmpty);
  });

  test('should be save a new search', () {
    final now = DateTime.now();
    final username = 'john';
    final data = {'login': 'john', 'id': 1};

    datasource.saveCurrentSearch(username, now, data);

    final saved = box.get('user_$username');

    expect(saved, isNotNull);
    expect(saved['search_date'], equals(now));
    expect(saved['data'], equals(data));
  });

  test('should be return previous searchs', () {
    final now = DateTime.now();
    final username = 'john';
    final userKey = 'user_$username';
    final data = {'login': 'john', 'id': 1};

    box.put(userKey, {
      'search_date': now,
      'data': data,
    });

    final result = datasource.getPastSearchs();

    expect(result, isNotNull);
    expect(result![userKey], isA<Map<String, dynamic>>());
    expect(result[userKey]['data'], equals(data));
  });

  test('should be return null if there no are searchs', () {
    box.clear();

    final result = datasource.getPastSearchs();

    expect(result, isEmpty);
  });
}
