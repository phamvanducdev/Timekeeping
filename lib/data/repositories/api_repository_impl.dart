import 'package:timekeeping/core/state.dart';
import 'package:timekeeping/data/models/user.dart';
import 'package:timekeeping/data/sources/remote/api_service.dart';
import 'package:timekeeping/domains/repositories/api_repository.dart';

class ApiRepositoryImpl extends ApiRepository {
  final ApiService _apiService;

  ApiRepositoryImpl(this._apiService);

  @override
  Future<State<User>> onLogin(String username, String password) async {
    try {
      final response = await _apiService.postLogin(
        username: username,
        password: password,
      );
      if (response.statusCode == 201) {
        return State.success(User.fromMap(response.data));
      }
      return State.failed(Exception('Failed with status: ${response.statusCode}'));
    } catch (e) {
      return State.failed(e as Exception);
    }
  }

  @override
  Future<State<User>> getUserById(String userId) async {
    try {
      final response = await _apiService.getUser(userId: userId);
      if (response.statusCode == 201) {
        return State.success(User.fromMap(response.data));
      }
      return State.failed(Exception('Failed with status: ${response.statusCode}'));
    } catch (e) {
      return State.failed(e as Exception);
    }
  }
}
