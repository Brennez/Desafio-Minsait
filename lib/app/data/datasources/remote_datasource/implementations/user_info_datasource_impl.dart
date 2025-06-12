import '../../../../../core/http/interface/interface_export.dart';
import '../interfaces/interfaces_export.dart';

class UserInfoDatasourceImpl implements UserInfoDatasource {
  final HttpClient httpClient;
  UserInfoDatasourceImpl({required this.httpClient});

  @override
  Future<Map<String, dynamic>> getUserInfo(String username) async {
    try {
      final response = await httpClient.get(
        'https://api.github.com/users/$username',
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load user info');
      }
    } catch (e) {
      throw Exception('Error fetching user info: $e');
    }
  }
}
