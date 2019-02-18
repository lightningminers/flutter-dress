class ResponseData<T>{
  final T data;
  final int errorCode;
  final String errorMessage;

  ResponseData(this.data, this.errorCode, this.errorMessage);
  ResponseData.fromJSON(Map<String, dynamic> json)
    : data = json['data'],
    errorCode = json['errorCode'],
    errorMessage = json['errorMessage'];
}