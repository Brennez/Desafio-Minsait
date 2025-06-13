import 'package:git_app/core/exceptions/not_found_exception.dart';

import '../../../../../core/http/interface/interface_export.dart';
import '../../../../presentation/enums/enums_export.dart';
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
        throw NotFoundException('Failed to load user info');
      }
    } catch (e) {
      throw Exception('Error fetching user info: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getAdvancedUserInfo(
      String username, String? data, FilterType filterType) async {
    try {
      final query = "$username+$data";
      final response = await httpClient.get(
        'https://api.github.com/search/users?q=$query',
      );
      if (response.statusCode == 200 && (response.data["total_count"] > 0)) {
        return response.data;
      } else {
        throw NotFoundException('Not found results');
      }
    } catch (e) {
      throw Exception('Error fetching advanced user info: $e');
    }
  }
}
