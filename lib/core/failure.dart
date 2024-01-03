import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String error;
  final int errorCode;

  const Failure(this.error, {this.errorCode = 0});

  @override
  List<Object> get props => [error, errorCode];
}
