class Response<T> {
  String? error;
  int? statusCode;
  T? body;

  Response({this.error, this.statusCode, this.body});
}
