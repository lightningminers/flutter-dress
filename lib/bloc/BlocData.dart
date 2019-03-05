class BlocData<T> {
  final T data;
  final String action;
  final dynamic params;

  BlocData(this.action, {
    this.params,
    this.data
  });
}
