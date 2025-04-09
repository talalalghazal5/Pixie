class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() => "Network error occured: $message";
}