class ErrorModel {
  int? statusDirectFromResponse;
  int? statusCode;
  late String message;
  ErrorModel.fromjson(Map<String, dynamic> json,
      {this.statusDirectFromResponse}) {
    statusCode = statusDirectFromResponse;
    message = json['message'];
  }
}
