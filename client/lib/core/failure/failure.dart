class ApiFailure {
  final String message;
  final int? statusCode;
  ApiFailure({this.message = "Something went wrong!", this.statusCode});
}