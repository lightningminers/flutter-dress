class ResponseData<T>{
  final T data;
  final int status;
  final String errorMessage;

  ResponseData(this.data, this.status, this.errorMessage);
  ResponseData.fromJSON(Map<String, dynamic> json)
    : data = json['data'],
    status = json['status'],
    errorMessage = json['errorMessage'];
}
