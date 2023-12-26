import 'package:timekeeping/core/state.dart';
import 'package:timekeeping/data/models/user.dart';

abstract class ApiRepository {
  Future<State<User>> onLogin(String username, String password);
  Future<State<User>> getUserById(String userId);
}
