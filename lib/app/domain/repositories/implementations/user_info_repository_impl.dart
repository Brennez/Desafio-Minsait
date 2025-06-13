import 'package:git_app/app/presentation/enums/enums_export.dart';

import '../../../data/datasources/remote_datasource/interfaces/interfaces_export.dart';
import '../../../data/models/models_export.dart';
import '../interfaces/interfaces_export.dart';

class UserInfoRepositoryImpl implements UserInfoRepository {
  final UserInfoDatasource userInfoDatasource;

  UserInfoRepositoryImpl({required this.userInfoDatasource});

  @override
  Future<UserModel> getUserInfo(String username) async {
    try {
      final userInfo = await userInfoDatasource.getUserInfo(username);
      return UserModel.fromMap(userInfo);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getAdvancedUserInfo(
      String username, String? data, FilterType type) async {
    try {
      final userInfo =
          await userInfoDatasource.getAdvancedUserInfo(username, data, type);
      final result = (userInfo["items"] as List).first as Map<String, dynamic>;
      return UserModel.fromMap(result);
    } catch (e) {
      rethrow;
    }
  }
}
