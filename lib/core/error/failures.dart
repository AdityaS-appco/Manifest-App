// Abstract Failure class
abstract class Failure {
  final String message;

  Failure(this.message);
}

// Concrete Failure types
class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class AudioFailure extends Failure {
  AudioFailure({required String message}) : super(message);
}
