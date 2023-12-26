import 'package:rxdart/subjects.dart';
import 'package:timekeeping/core/constants/shared_pref.dart';
import 'package:timekeeping/core/state.dart';
import 'package:timekeeping/domains/repositories/api_repository.dart';

class LoginViewModel {
  final ApiRepository apiRepository;

  LoginViewModel(this.apiRepository);

  final BehaviorSubject<bool> _streamLoading = BehaviorSubject<bool>();
  Stream<bool> get streamLoading => _streamLoading.stream;

  Future<void> onLogin({
    required String username,
    required String password,
    required void Function() onSuccess,
    required void Function(String) onFailed,
  }) async {
    try {
      _streamLoading.add(true);
      final result = await apiRepository.onLogin(username, password);
      if (result is Success && result.data != null) {
        await SharedPref.setCurrentUser(result.data!);
        _streamLoading.add(false);
        onSuccess();
        return;
      }
      _streamLoading.add(false);
      onFailed(result.exception.toString());
    } catch (e) {
      _streamLoading.add(false);
      onFailed(e.toString());
    }
  }
}
