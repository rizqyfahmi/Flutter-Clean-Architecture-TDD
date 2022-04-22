import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/util/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia concrete;
  final GetRandomNumberTrivia random;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.concrete,
    required this.random,
    required this.inputConverter
  }) : super(Empty()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      final inputEither = inputConverter.stringToUnsignedInteger(event.numberString);
      await inputEither.fold(
        (inputEitherLeft) {
          emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE));
        }, 
        (inputEitherRight) async {
          emit(Loading());
          final concreteEither = await concrete(Params(number: inputEitherRight));
          concreteEither!.fold(
            (concreteEitherLeft) {
              emit(Error(message: _mapFailureToMessage(concreteEitherLeft)));
            }, 
            (concreteEitherRight) {
              emit(Loaded(trivia: concreteEitherRight));
            }
          );
        }
      );
    });
    on<GetTriviaForRandomNumber>((event, emit) async {
      emit(Loading());
      final randomEither = await random(NoParam());
      randomEither?.fold(
        (randomEitherLeft) => emit(Error(message: _mapFailureToMessage(randomEitherLeft))), 
        (randomEitherRight) => emit(Loaded(trivia: randomEitherRight))
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error";
    }
  }
}
