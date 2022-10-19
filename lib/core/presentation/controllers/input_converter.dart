import 'package:dartz/dartz.dart';

import '../../core.dart';

class InputConverter {
  Either<Failure, int> stringToInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException('Número inválido');
      return Right(integer);
    } on FormatException{
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}