import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class NumberTriviaRemoteDataSourceTest {
  HttpClient httpClient;

  NumberTriviaRemoteDataSourceTest({required this.httpClient});

  Future<void> getConcreteRandomNumberTrivia() async {
    await httpClient.getUrl(Uri.https('www.google.com.br', '/imagens'));
  }
}


void main() {
  test('Should call HTTPS Client correctly', () async {
    final httpClient = HttpClient();
    final sut = NumberTriviaRemoteDataSourceTest(httpClient: httpClient);
    await sut.getConcreteRandomNumberTrivia();
    verify(httpClient.getUrl(Uri.https('www.google.com.br', '/imagens')));
  });
}