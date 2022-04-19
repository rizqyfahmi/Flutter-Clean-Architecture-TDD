
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'get_random_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  test("Should get trivia for the random number from the repository", () async {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);

    const tNumberTrivia = NumberTrivia(text: "test", number: 1);

    when(mockNumberTriviaRepository.getRandomNumberTrivia()).thenAnswer((_) async => const Right(tNumberTrivia));

    final result = await usecase(NoParam());
    expect(result, const Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}