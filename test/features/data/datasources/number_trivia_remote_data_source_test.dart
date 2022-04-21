import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../fixtures/fixture.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late NumberTriviaRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockClient = MockClient();
    remoteDataSource = NumberTriviaRemoteDataSourceImpl(
      client: mockClient
    );
  });

  group("getConcreteNumberTrivia", () {
    const tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJSON(json.decode(fixture("trivia.json")));
    test("Should perform a GET request on a URL with number being the endpoint and with application/json header", () {
      // arrange
      when(mockClient.get(any, headers: {'Content-Type': 'application/json'})).thenAnswer((_) async => http.Response(fixture("trivia.json"), 200));
      // act
      remoteDataSource.getConcreteNumberTrivia(tNumber);
      // assert
      verify(mockClient.get(
        Uri.parse("https://numbersapi.com/$tNumber"),
        headers: {'Content-Type': 'application/json'}
      ));
    });

    test("Should return NumberTrivia when the response is 200", () async {
      // arrange
      when(mockClient.get(any, headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response(fixture("trivia.json"), 200));
      // act
      final result = await remoteDataSource.getConcreteNumberTrivia(tNumber);
      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test("Should throw a ServerException when the response code is 404 or other", () async {
      // arrange
      when(mockClient.get(any, headers: {'Content-Type': 'application/json'})).thenAnswer((_) async => http.Response("Something went wrong", 404));
      // act
      final call = remoteDataSource.getConcreteNumberTrivia;
      // assert
      expect(() => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group("getRandomNumberTrivia", () {
    const tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJSON(json.decode(fixture("trivia.json")));
    test("Should perform a GET request on a URL with number being the endpoint and with application/json header", () {
      // arrange
      when(mockClient.get(any, headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response(fixture("trivia.json"), 200));
      // act
      remoteDataSource.getRandomNumberTrivia();
      // assert
      verify(mockClient.get(Uri.parse("https://numbersapi.com/random"),
          headers: {'Content-Type': 'application/json'}));
    });

    test("Should return NumberTrivia when the response is 200", () async {
      // arrange
      when(mockClient.get(any, headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response(fixture("trivia.json"), 200));
      // act
      final result = await remoteDataSource.getRandomNumberTrivia();
      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        "Should throw a ServerException when the response code is 404 or other",
        () async {
      // arrange
      when(mockClient.get(any, headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response("Something went wrong", 404));
      // act
      final call = remoteDataSource.getRandomNumberTrivia;
      // assert
      expect(
          () => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}