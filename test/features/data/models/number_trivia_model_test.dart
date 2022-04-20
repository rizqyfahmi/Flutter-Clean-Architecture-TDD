import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../fixtures/fixture.dart';

void main() {
  const tNumberTrivia = NumberTriviaModel(number: 1, text: "Test Text");

  test("Should be a subclass of NumberTrivia entity", () {
    expect(tNumberTrivia, isA<NumberTrivia>());
  });

  group("fromJson", () {
    test("Should return a valid model when the JSON number is an integer", () async {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture("trivia.json"));
      // act
      final result = NumberTriviaModel.fromJSON(jsonMap);
      // assert
      expect(result, tNumberTrivia);
    });

    test("Should return a valid model when the JSON number is regarded as a double", () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture("trivia_double.json"));
      // act
      final result = NumberTriviaModel.fromJSON(jsonMap);
      // assert
      expect(result, tNumberTrivia);
    });
  });

}