import 'package:flutter/material.dart';
import 'package:timekeeping/core/constants/shared_pref.dart';
import 'package:timekeeping/core/helpers/locations.dart';
import 'package:timekeeping/core/state.dart';
import 'package:timekeeping/domains/repositories/api_repository.dart';

class HomeViewModel {
  final ApiRepository _apiRepository;

  HomeViewModel(this._apiRepository);

  Future<void> initialize({
    required Function() onLogin,
    required Function(String) onFailed,
  }) async {
    try {
      final userInfo = await SharedPref.getCurrentUser();
      if (userInfo == null) {
        onLogin();
        return;
      }
      return;
      final userInfoResult = await _apiRepository.getUserById(userInfo.userId);
      if (userInfoResult is Success) {
        await requestLocations();
      } else {
        onLogin();
        return;
      }
    } catch (e) {
      onFailed(e.toString());
      return;
    }
  }

  Future<void> requestLocations() async {
    try {
      final position = await LocationHelper.determinePosition();
      debugPrint('$position');
    } catch (e) {
      debugPrint('Failed to requestLocations $e');
    }
  }
}
