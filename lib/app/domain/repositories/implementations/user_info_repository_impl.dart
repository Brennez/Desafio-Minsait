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
}
