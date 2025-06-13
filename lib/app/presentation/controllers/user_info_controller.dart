import 'package:get/get.dart';
import 'package:git_app/app/data/models/models_export.dart';
import 'package:git_app/app/domain/repositories/interfaces/interfaces_export.dart';
import 'package:git_app/app/presentation/enums/enums_export.dart';
import 'package:git_app/core/exceptions/not_found_exception.dart';

class UserInfoController extends GetxController {
  final UserInfoRepository _userInfoRepository;

  UserInfoController(this._userInfoRepository);

  final Rx<ScreenState> _screenState = ScreenState.initial.obs;

  ScreenState get screenState => _screenState.value;

  UserModel? userInfo;

  void setScreenState(ScreenState state) {
    _screenState.value = state;
  }

  void setUserInfo(UserModel? user) {
    userInfo = user;
  }

  Future<void> getUserInfo(String username) async {
    setScreenState(ScreenState.loading);
    try {
      userInfo = await _userInfoRepository.getUserInfo(username);
      setScreenState(ScreenState.success);
    } on NotFoundException catch (e) {
      setScreenState(ScreenState.notFound);
    } catch (e) {
      setScreenState(ScreenState.error);
    }
  }

  Future<void> getAdvancedUserInfo(
      String username, String? data, FilterType type) async {
    setScreenState(ScreenState.loading);
    try {
      userInfo =
          await _userInfoRepository.getAdvancedUserInfo(username, data, type);
      setScreenState(ScreenState.success);
    } on NotFoundException catch (e) {
      setScreenState(ScreenState.notFound);
    } catch (e) {
      setScreenState(ScreenState.error);
    }
  }
}
