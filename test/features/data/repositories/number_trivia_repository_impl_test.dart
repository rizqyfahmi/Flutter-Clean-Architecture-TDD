
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([
  NumberTriviaRemoteDataSource, 
  NumberTriviaLocalDataSource, 
  NetworkInfo
])
void main() {
  NumberTriviaRemoteDataSource mockRemoteDataSource = MockNumberTriviaRemoteDataSource();
  NumberTriviaLocalDataSource mockLocalDataSource = MockNumberTriviaLocalDataSource();
  NetworkInfo mockNetworkInfo = MockNetworkInfo();
  NumberTriviaRepositoryImpl repository = NumberTriviaRepositoryImpl(
    remoteDataSource: mockRemoteDataSource,
    localDataSource: mockLocalDataSource,
    networkInfo: mockNetworkInfo
  );

  group("getConcreteNumberTrivia", () {
    const tNumber = 1;
    const tNumberTriviaModel = NumberTriviaModel(text: "Test Text", number: tNumber);
    const NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test("Should check if the device is online", () {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async => tNumberTriviaModel);
      // act
      repository.getConcreteNumberTrivia(tNumber);
      // assert
      verify(mockNetworkInfo.isConnected); // verify that mockNetworkInfo.isConnected is called
    });

    group("Device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test("Should return remote data when the call to remote data source is success", () async {
        // arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async => tNumberTriviaModel);
        // act
        final result = await repository.getConcreteNumberTrivia(tNumber);
        // assert
        verify(mockRemoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result, const Right(tNumberTrivia));
      });
    });
  });
}