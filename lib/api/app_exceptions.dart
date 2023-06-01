class AppException implements Exception {
  final String _message;
  final String _prefix;

  AppException(
    this._message,
    this._prefix,
  );

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException({required String message})
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException({required String message})
      : super(message, "Invalid Input: ");
}

class ValidationException extends AppException {
  ValidationException() : super("", "");
}
