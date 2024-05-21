class HomeState<T> {
  final bool isInitial;

  final bool isInProgress;
  final bool isOnLoadmore;
  final bool isEmpty;

  final bool isDetail;

  final bool isFailure;
  final bool isSuccess;
  final String? message;
  final T? data;

  const HomeState({
    this.isInitial = false,
    this.isInProgress = false,
    this.isOnLoadmore = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.isDetail = false,
    this.isEmpty = false,
    this.message = "",
    this.data,
  });

  factory HomeState.initial() => const HomeState(isInitial: true);

  factory HomeState.inProgress() => const HomeState(isInProgress: true);

  factory HomeState.failure(String? message) =>
      HomeState(isFailure: true, message: message);

  factory HomeState.empty() => const HomeState(isEmpty: true);

  factory HomeState.success({required T data}) =>
      HomeState(isSuccess: true, data: data);

  factory HomeState.detail({required T data}) =>
      HomeState(isSuccess: true, data: data);

  factory HomeState.onLoadmore() => const HomeState(
        isOnLoadmore: true,
      );
}
