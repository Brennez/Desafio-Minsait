import 'package:flutter_test/flutter_test.dart';
import 'package:git_app/app/domain/repositories/implementations/implementations_export.dart';
import 'package:mocktail/mocktail.dart';

import 'package:git_app/app/data/models/user_model.dart';
import 'package:git_app/app/data/datasources/remote_datasource/interfaces/user_info_datasource.dart';
import 'package:git_app/app/presentation/enums/enums_export.dart';

class MockUserInfoDatasource extends Mock implements UserInfoDatasource {}

void main() {
  late UserInfoRepositoryImpl repository;
  late MockUserInfoDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockUserInfoDatasource();
    repository = UserInfoRepositoryImpl(userInfoDatasource: mockDatasource);
  });

  final username = 'john';

  test('getUserInfo should return UserModel on search data', () async {
    final userMap = {'login': 'john', 'id': 1};

    when(() => mockDatasource.getUserInfo(username))
        .thenAnswer((_) async => userMap);

    final result = await repository.getUserInfo(username);

    expect(result, isA<UserModel>());
    expect(result.username, equals('john'));
    expect(result.id, equals(1));
    verify(() => mockDatasource.getUserInfo(username)).called(1);
  });

  test('getUserInfo should rethrown exception throwed by datasource', () async {
    when(() => mockDatasource.getUserInfo(username))
        .thenThrow(Exception('Erro na datasource'));

    expect(() => repository.getUserInfo(username), throwsException);
    verify(() => mockDatasource.getUserInfo(username)).called(1);
  });

  test('getAdvancedUserInfo should return UserModel with advanced data',
      () async {
    final filterType = FilterType.location;
    final advancedData = {
      'items': [
        {'login': 'john', 'id': 1}
      ]
    };

    when(() => mockDatasource.getAdvancedUserInfo(
            username, 'location:Brazil', filterType))
        .thenAnswer((_) async => advancedData);

    final result = await repository.getAdvancedUserInfo(
        username, 'location:Brazil', filterType);

    expect(result, isA<UserModel>());
    expect(result.username, equals('john'));
    expect(result.id, equals(1));
    verify(() => mockDatasource.getAdvancedUserInfo(
        username, 'location:Brazil', filterType)).called(1);
  });

  test('getAdvancedUserInfo should rethrown exception throwed by datasource',
      () async {
    final filterType = FilterType.location;

    when(() => mockDatasource.getAdvancedUserInfo(
            username, 'location:Brazil', filterType))
        .thenThrow(Exception('Erro na datasource'));

    expect(
        () => repository.getAdvancedUserInfo(
            username, 'location:Brazil', filterType),
        throwsException);
    verify(() => mockDatasource.getAdvancedUserInfo(
        username, 'location:Brazil', filterType)).called(1);
  });
}
