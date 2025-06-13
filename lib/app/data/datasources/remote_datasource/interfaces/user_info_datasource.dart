import '../../../../presentation/enums/enums_export.dart';

abstract class UserInfoDatasource {
  Future<Map<String, dynamic>> getUserInfo(String username);

  Future<Map<String, dynamic>> getAdvancedUserInfo(
      String username, String? data, FilterType filterType);
}
