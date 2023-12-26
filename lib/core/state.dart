abstract class State<T> {
  final T? data;
  final Exception? exception;

  const State({this.data, this.exception});

  factory State.success(T data) => Success(data);

  factory State.failed(Exception exception) => Failed(exception);
}

class Success<T> extends State<T> {
  const Success(T data) : super(data: data);
}

class Failed<T> extends State<T> {
  const Failed(Exception? exception) : super(exception: exception);
}
