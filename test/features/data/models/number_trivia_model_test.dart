import 'package:flutter_test/flutter_test.dart';

void main() {
  const tNumberTrivia = NumberTriviaModel(number: 1, text: "Test Text");

  test("Should be a subclass of NumberTrivia entity", () {
    expect(tNumberTrivia, isA<NumberTrivia>());
  });

}