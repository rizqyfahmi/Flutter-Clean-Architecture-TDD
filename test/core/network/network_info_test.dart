
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/network/network_info.dart';


import 'network_info_test.mocks.dart';

@GenerateMocks([DataConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(
      dataConnectionChecker: mockDataConnectionChecker
    );
  });

  group("isConnected", () {
    test("Should forward the call to DataConnectionChecker.hasConnection", () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);
      when(mockDataConnectionChecker.hasConnection).thenAnswer((_) => tHasConnectionFuture);
      // act
      // we don't use await because in this part we only want to forward DataConnectionChecker.hasConnection
      final result = networkInfo.isConnected;
      // assert
      verify(mockDataConnectionChecker.hasConnection);
      // Utilizing Dart's default referential equality.
      // Only references to the same object are equal.
      expect(result, tHasConnectionFuture);
    });
  });
}