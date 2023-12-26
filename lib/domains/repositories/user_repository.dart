import 'package:timekeeping/data/models/user.dart';

abstract class UserRepository {
  Future<User?> getUserStored();
  Future<void> setUserStored(User user);
}
