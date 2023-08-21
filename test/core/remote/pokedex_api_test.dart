import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/core.dart';

import '../../fixtures/fixture.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late Dio dio;
  late PokedexApi pokedexApi;
  group('Pokedex Api', () {
    setUp(() {
      dio = MockDio();
      // dioAdapter = MockDioAdapter();
      // dio.httpClientAdapter = dioAdapter;
      pokedexApi = PokedexApiImpl(dio: dio);
    });

    group('constructor', () {
      test('defaults to internal Dio if none is provided', () {
        expect(PokedexApiImpl.new, isNot(throwsA(isA<Exception>())));
      });
    });

    group('Get pokemon details calls dio api', () {
      test('returns PokemonDetailResponse if the request is successful',
          () async {
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

        verify(() => dio.get<dynamic>(any())).called(1);
      });

      test(
          'throws GetPokemonException '
          'if dio.get returns other status code apart from 200', () {
        final dioResponse = Response(
          data: 'Unable to get pokemon details, Try again',
          requestOptions: RequestOptions(),
          statusCode: 400,
        );
        when(() => dio.get<dynamic>(any()))
            .thenAnswer((_) async => dioResponse);

        expect(
          () => pokedexApi.getPokemonDetails('bulbasaur'),
          throwsA(isA<GetPokemonDetailsException>()),
        );
      });

      test(
          'throws GetPokemonException '
          'if dio.get throws DioException', () {
        when(() => dio.get<dynamic>(any()))
            .thenThrow(DioException(requestOptions: RequestOptions()));

        expect(
          () => pokedexApi.getPokemonDetails('bulbasaur'),
          throwsA(isA<GetPokemonDetailsException>()),
        );
      });
    });

    group('Get pokemon list calls dio api', () {
      test('returns PokemonResponse if the request is successful', () async {
        final rawData = fixture('pokemon_list.json');
        final data = jsonDecode(rawData) as Map<String, dynamic>;
        final response = PokemonResponse.fromJson(data);
        final dioResponse = Response(
          data: jsonDecode(rawData),
          requestOptions: RequestOptions(),
          statusCode: 200,
        );
        when(() => dio.get<dynamic>(any()))
            .thenAnswer((_) async => dioResponse);

        final actual = await pokedexApi.getPokemonList(limit: 0, offset: 0);

        expect(
          actual,
          response,
        );

        verify(() => dio.get<dynamic>(any())).called(1);
      });

      test(
          'throws GetPokemonException '
          'if dio.get returns other status code apart from 200', () {
        final dioResponse = Response(
          data: 'Unable to get pokemon, Try again',
          requestOptions: RequestOptions(),
          statusCode: 400,
        );
        when(() => dio.get<dynamic>(any()))
            .thenAnswer((_) async => dioResponse);

        expect(
          () => pokedexApi.getPokemonList(),
          throwsA(isA<GetPokemonException>()),
        );
      });

      test(
          'throws GetPokemonException '
          'if dio.get throws DioException', () {
        when(() => dio.get<dynamic>(any())).thenThrow(
          DioException(
            error: 'error',
            requestOptions: RequestOptions(),
          ),
        );

        expect(
          () => pokedexApi.getPokemonList(),
          throwsA(isA<GetPokemonException>()),
        );
      });
    });

    group('Pokedex Api Exceptions', () {
      test('', () {
        expect(
          GetPokemonException('errorMessage').toString(),
          'errorMessage',
        );
      });
      test('', () {
        expect(
          GetPokemonDetailsException('errorMessage').toString(),
          'errorMessage',
        );
      });
    });
  });
}
