import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/core.dart';

import '../../fixtures/fixture.dart';

class MockDioAdapter extends Mock implements HttpClientAdapter {}

class MockDio extends Mock implements Dio {}

void main() {
  late Dio dio;
  late MockDioAdapter dioAdapter;
  late PokedexApi pokedexApi;
  group('Pokedex Api', () {
    setUp(() {
      dio = MockDio();
      // dioAdapter = MockDioAdapter();
      // dio.httpClientAdapter = dioAdapter;
      pokedexApi = PokedexApiImpl(dio: dio);
    });

    group('Get pokemon details calls dio api', () {
      test('description', () async {
        final rawData = fixture('pokemon_details.json');
        final data = jsonDecode(rawData) as Map<String, dynamic>;
        final response = PokemonDetailResponse.fromJson(data);
        final dioResponse = Response(
          data: jsonDecode(rawData),
          requestOptions: RequestOptions(),
          statusCode: 200,
        );
        when(() => dio.get<dynamic>(any()))
            .thenAnswer((_) async => dioResponse);

        final actual = await pokedexApi.getPokemonDetails('bulbasaur');

        expect(
          actual,
          response,
        );
      });
    });
  });
}
