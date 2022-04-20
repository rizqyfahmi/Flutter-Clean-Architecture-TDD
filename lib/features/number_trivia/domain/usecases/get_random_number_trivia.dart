import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class GetRandomNumberTrivia implements Usecase<NumberTrivia, NoParam> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParam noParam) {
    return repository.getRandomNumberTrivia();
  }
  
}

class NoParam extends Equatable{
  @override
  List<Object?> get props => [];
  
}