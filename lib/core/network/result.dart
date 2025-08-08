import 'package:manifest/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class Result<T> {
  final Either<Failure, T> _either;

  Result.success(T data) : _either = Right(data);
  Result.failure(Failure error) : _either = Left(error);

  void fold({
    required Function(T data) onSuccess,
    required Function(Failure error) onFailure,
  }) {
    _either.fold(
      (failure) => onFailure(failure),
      (data) => onSuccess(data),
    );
  }

  bool get isSuccess => _either.isRight();
  T? get data => _either.fold((l) => null, (r) => r);
  Failure? get error => _either.fold((l) => l, (r) => null);
}
