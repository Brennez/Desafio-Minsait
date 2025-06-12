import 'package:get/get.dart';
import 'package:git_app/app/data/models/models_export.dart';

import '../../domain/repositories/interfaces/interfaces_export.dart';
import '../enums/screen_state_enum.dart';

class CacheController extends GetxController {
  final CacheRepository _cacheRepository;
  CacheController(this._cacheRepository);

  final Rx<ScreenState> _screenState = ScreenState.initial.obs;

  ScreenState get screenState => _screenState.value;

  void setScreenState(ScreenState state) {
    _screenState.value = state;
  }

  Future<void> clearAllCache() async {
    try {
      setScreenState(ScreenState.loading);

      await _cacheRepository.clearAllCache();

      setScreenState(ScreenState.success);
    } catch (e) {
      setScreenState(ScreenState.error);
      rethrow;
    }
  }

  Future<void> saveUserCache(String username, Map<String, dynamic> data) async {
    try {
      setScreenState(ScreenState.loading);

      await _cacheRepository.saveUserCache(username, data);

      setScreenState(ScreenState.success);
    } catch (e) {
      setScreenState(ScreenState.error);
      rethrow;
    }
  }

  Future<UserModel?> getUserCache(String username) async {
    try {
      setScreenState(ScreenState.loading);
      final data = _cacheRepository.getUserCache(username);
      setScreenState(ScreenState.success);
      return data;
    } catch (e) {
      setScreenState(ScreenState.error);
      rethrow;
    }
  }
}
