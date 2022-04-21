import 'dart:convert';

import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  // Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client _client;

  NumberTriviaRemoteDataSourceImpl({
    required http.Client client
  }) : _client = client;

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    return _getTrivia("https://numbersapi.com/$number");
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _getTrivia("https://numbersapi.com/random");
  }

  Future<NumberTriviaModel> _getTrivia(String url) async {
    final response = await _client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJSON(json.decode(response.body));  
    }

    throw ServerException();
  }
  
}