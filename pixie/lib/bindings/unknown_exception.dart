class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);

  @override
  String toString() => "Error occured: $message";
}