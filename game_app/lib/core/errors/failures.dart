import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

// خطأ جاي من الـ API (مثل 404 أو 500)
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// خطأ في الاتصال بالإنترنت
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}