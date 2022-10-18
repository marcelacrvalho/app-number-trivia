import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../core/core.dart';
import '../data.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

abstract class NumberTriviaRemoteDataSourceImpl
    implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getTriviaFromURL(number.toString());

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getTriviaFromURL('random');

  Future<NumberTriviaModel> _getTriviaFromURL(String unencodedPath) async {
    final response = await client.get(
        Uri.http('numbersapi.com', '/$unencodedPath'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: 'Não foi possível se conectar');
    }
  }
}
