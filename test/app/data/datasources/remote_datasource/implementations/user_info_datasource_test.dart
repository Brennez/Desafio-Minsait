import 'package:git_app/app/data/datasources/remote_datasource/implementations/implementations_export.dart';
import 'package:git_app/app/presentation/enums/enums_export.dart';
import 'package:git_app/core/http/interface/interface_export.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpResponse extends Mock implements HttpResponse {}

extension MockHttpClientExtension on MockHttpClient {
  Future<MockHttpResponse> get(String url) async {
    return MockHttpResponse();
  }
}

void main() {
  late MockHttpClient mockHttpClient;
  late UserInfoDatasourceImpl datasource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = UserInfoDatasourceImpl(httpClient: mockHttpClient);
  });

  test('should be return data when status code was 200', () async {
    final response = MockHttpResponse();

    when(() => response.statusCode).thenReturn(200);

    when(() => response.data).thenReturn({'login': 'john', 'id': 1});

    when(() => mockHttpClient.get(any())).thenAnswer((_) async => response);

    final result = await datasource.getUserInfo('john');

    expect(result['login'], equals('john'));
  });

  test('should be thrown Exception when statusCode for different than 200',
      () async {
    final response = MockHttpResponse();

    when(() => response.statusCode).thenReturn(404);

    expect(
      () async => await datasource.getUserInfo('usuario_invalido'),
      throwsA(isA<Exception>()),
    );
  });

  test(
      'should be return data when the advanced search result status code was 200',
      () async {
    final response = MockHttpResponse();

    when(() => response.statusCode).thenReturn(200);

    when(() => response.data).thenReturn({'total_count': 1});

    when(() => mockHttpClient.get(any())).thenAnswer((_) async => response);

    final result = await datasource.getAdvancedUserInfo(
        "john", "location:Brazil", FilterType.location);

    expect(result['total_count'], equals(1));
  });

  test(
      'should be thrown an Exception when the advanced search status code be different than 200',
      () async {
    final response = MockHttpResponse();

    when(() => response.statusCode).thenReturn(404);

    expect(
      () async => await datasource.getAdvancedUserInfo(
          'not_found_user', "location:none", FilterType.none),
      throwsA(isA<Exception>()),
    );
  });
}
