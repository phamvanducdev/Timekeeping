abstract class UseCase<T> {
  Future<T> invoke();
}

abstract class UseCaseParams<T, Params> {
  Future<T> invoke(Params params);
}
