abstract class UseCase<T, Param> {
  T call(Param param);
}

abstract class NoParamsUseCase<T> {
  T call();
}
