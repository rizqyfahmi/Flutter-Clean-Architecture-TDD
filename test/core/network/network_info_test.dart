
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/network/network_info.dart';


import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(
      connectionChecker: mockInternetConnectionChecker
    );
  });

  group("isConnected", () {
    /*
      If you get "Can't run with sound null safety because dependencies don't support null safety"
      - Visual code studio: 
        - Go to setting in preferences
        - make sure you're in user tab, then search "Flutter test additional args"
        - Add "--no-sound-null-safety"
    */
    test("Should forward the call to DataConnectionChecker.hasConnection", () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);
      when(mockInternetConnectionChecker.hasConnection).thenAnswer((_) => tHasConnectionFuture);
      // act
      // we don't use await because in this part we only want to forward DataConnectionChecker.hasConnection
      final result = networkInfo.isConnected;
      // assert
      verify(mockInternetConnectionChecker.hasConnection);
      // Utilizing Dart's default referential equality.
      // Only references to the same object are equal.
      expect(result, tHasConnectionFuture);
    });
  });
}