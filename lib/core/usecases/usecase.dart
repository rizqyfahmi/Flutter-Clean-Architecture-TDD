import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>?>? call(Params param);
}