
import 'package:mockito/annotations.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

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
}