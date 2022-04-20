import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required String text,
    required int number
  }) : super(text: text, number: number);

  factory NumberTriviaModel.fromJSON(Map<String, dynamic> response) {
    return NumberTriviaModel(text: response["text"], number: response["number"]);
  }
}