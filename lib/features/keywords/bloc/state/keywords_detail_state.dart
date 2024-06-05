class KeywordsDetailState<T> {
  final bool isInProgress;
  final bool isFailure;
  final bool isSuccess;
  final bool isMutateDataSuccess;
  final bool isEmpty;
  final String? message;
  final T? data;

  const KeywordsDetailState({
    this.isInProgress = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.isMutateDataSuccess = false,
    this.isEmpty = false,
    this.message = "",
    this.data,
  });

  factory KeywordsDetailState.initial() => const KeywordsDetailState();

  factory KeywordsDetailState.inProgress() => const KeywordsDetailState(isInProgress: true);

  factory KeywordsDetailState.failure(String? message) =>
      KeywordsDetailState(isFailure: true, message: message);

  factory KeywordsDetailState.empty() => const KeywordsDetailState(isEmpty: true);

  factory KeywordsDetailState.success({required T data}) =>
      KeywordsDetailState(isSuccess: true, data: data);

  factory KeywordsDetailState.mutateDataSuccess({required String message}) =>
      KeywordsDetailState(isMutateDataSuccess: true, message: message);
}
