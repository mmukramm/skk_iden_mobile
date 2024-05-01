class DataState<T> {
  final bool isInProgress;
  final bool isFailure;
  final bool isSuccess;
  final bool isEmpty;
  final String? message;
  final T? data;

  const DataState({
    this.isInProgress = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.isEmpty = false,
    this.message = "",
    this.data,
  });

  factory DataState.initial() => const DataState();

  factory DataState.inProgress() => const DataState(isInProgress: true);

  factory DataState.failure(String? message) =>
      DataState(isFailure: true, message: message);

  factory DataState.empty() => const DataState(isEmpty: true);

  factory DataState.success({required T data}) => DataState(isSuccess: true, data: data);
}
