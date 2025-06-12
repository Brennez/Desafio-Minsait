import '../../../data/models/models_export.dart';

abstract class UserInfoRepository {
  Future<UserModel> getUserInfo(String username);
}
