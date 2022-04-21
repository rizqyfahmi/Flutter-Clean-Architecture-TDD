import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDataSourceImpl localDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences
    );
  });

  group("getLastNumberTrivia", () {
    final tNumberTriviaModel = NumberTriviaModel.fromJSON(json.decode(fixture("trivia_cached.json")));
    test("Should return NumberTrivia from SharedPreferences when there is one in the cache", () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(fixture("trivia_cached.json"));
      // act
      final result = await localDataSource.getLastNumberTrivia();
      // assert
      verify(mockSharedPreferences.getString("CACHED_NUMBER_TRIVIA"));
      expect(result, equals(tNumberTriviaModel));
    });

    test("Should throw CachedException when there is not a cached value", () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = localDataSource.getLastNumberTrivia;
      // assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group("cacheNumberTrivia", () {
    const tNumberTriviaModel = NumberTriviaModel(text: "Test Trivia", number: 1);

    test("Should call SharedPreferences to cache the data", () {
      // arrange
      when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);
      // act
      localDataSource.cacheNumberTrivia(tNumberTriviaModel);
      // assert
      verify(mockSharedPreferences.setString("CACHED_NUMBER_TRIVIA", json.encode(tNumberTriviaModel)));
    });
  });
}