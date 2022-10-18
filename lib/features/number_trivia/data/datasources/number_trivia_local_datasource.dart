import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../../core/core.dart';
import '../data.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    return jsonString != null
        ? Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)))
        : throw CacheException();
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) async {
    sharedPreferences.setString(
        CACHED_NUMBER_TRIVIA, jsonEncode(triviaToCache.toJson()));
  }
}