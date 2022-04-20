import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({  
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo
  });

  @override
  Future<Either<Failure, NumberTrivia>>? getConcreteNumberTrivia(int number) async {
    try {
      networkInfo.isConnected;
      final remoteData = await remoteDataSource.getConcreteNumberTrivia(number);
      localDataSource.cacheNumberTrivia(remoteData);
      return Right(remoteData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
  
}