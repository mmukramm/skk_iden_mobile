class KeywordsState<T> {
  final bool isInProgress;
  final bool isOnLoadmore;
  final bool isFailure;
  final bool isSuccess;
  final bool isMutateDataSuccess;
  final bool isEmpty;
  final String? message;
  final T? data;

  const KeywordsState({
    this.isInProgress = false,
    this.isOnLoadmore = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.isMutateDataSuccess = false,
    this.isEmpty = false,
    this.message = "",
    this.data,
  });

  factory KeywordsState.initial() => const KeywordsState();

  factory KeywordsState.inProgress() => const KeywordsState(isInProgress: true);

  factory KeywordsState.failure(String? message) =>
      KeywordsState(isFailure: true, message: message);

  factory KeywordsState.empty() => const KeywordsState(isEmpty: true);

  factory KeywordsState.success({required T data}) =>
      KeywordsState(isSuccess: true, data: data);

  factory KeywordsState.onLoadmore() => const KeywordsState(
        isOnLoadmore: true,
      );

  factory KeywordsState.mutateDataSuccess({required String message}) =>
      KeywordsState(isMutateDataSuccess: true, message: message);
}
