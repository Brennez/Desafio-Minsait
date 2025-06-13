import '../../../data/models/models_export.dart';
import '../../../presentation/enums/enums_export.dart';

abstract class UserInfoRepository {
  Future<UserModel> getUserInfo(String username);

  Future<UserModel> getAdvancedUserInfo(
      String username, String? data, FilterType type);
}
