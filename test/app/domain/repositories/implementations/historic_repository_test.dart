import 'package:flutter_test/flutter_test.dart';
import 'package:git_app/app/domain/repositories/implementations/historic_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import 'package:git_app/app/data/datasources/local_datasource/interfaces/local_historic_datasource.dart';
import 'package:git_app/app/data/models/historic_model.dart';

class MockLocalHistoricDatasource extends Mock
    implements LocalHistoricDatasource {}

void main() {
  late HistoricRepositoryImpl repository;
  late MockLocalHistoricDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockLocalHistoricDatasource();
    repository = HistoricRepositoryImpl(localHistoric: mockDatasource);
  });

  test('getPastSearchs deve retornar lista de HistoricModel', () {
    final mockData = {
      'user_john': {
        'search_date': DateTime.parse('2023-01-01T00:00:00Z'),
        'data': {'login': 'john'}
      }
    };

    when(() => mockDatasource.getPastSearchs()).thenReturn(mockData);

    final result = repository.getPastSearchs();

    expect(result, isA<List<HistoricModel>>());
    expect(result.length, 1);
    expect(result.first.userModel.username, equals('john'));
  });

  test(
      'getPastSearchs should retrurn an empty list when datasource returns null',
      () {
    when(() => mockDatasource.getPastSearchs()).thenReturn(null);

    final result = repository.getPastSearchs();

    expect(result, isEmpty);
  });

  test('getPastSearchs should throw exception if datasource fails', () {
    when(() => mockDatasource.getPastSearchs()).thenThrow(Exception('error'));

    expect(() => repository.getPastSearchs(), throwsException);
  });

  test('saveCurrentSearch should call datasource with correct params', () {
    final username = 'john';
    final date = DateTime.now();
    final data = {'login': 'john'};

    when(() => mockDatasource.saveCurrentSearch(username, date, data))
        .thenReturn(null);

    repository.saveCurrentSearch(username, date, data);

    verify(() => mockDatasource.saveCurrentSearch(username, date, data))
        .called(1);
  });

  test('saveCurrentSearch should throw exception if datasource fails', () {
    final username = 'john';
    final date = DateTime.now();
    final data = {'login': 'john'};

    when(() => mockDatasource.saveCurrentSearch(username, date, data))
        .thenThrow(Exception('erro'));

    expect(() => repository.saveCurrentSearch(username, date, data),
        throwsException);
  });
}
