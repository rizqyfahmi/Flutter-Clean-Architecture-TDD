import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(number: tNumber, text: "Test");

  test("should get trivia for the number from the repository", () async {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);

    when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async => const Right(tNumberTrivia));

    final result = await usecase.execute(number: tNumber);
    expect(result, const Right(tNumberTrivia));
    // Verify that "mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber)" is called
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
    // Verify that is no more interaction happening on mockNumberTriviaRepository after we call execute of the usecase
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}