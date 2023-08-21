import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/core.dart';

import '../../fixtures/fixture.dart';

class MockPokedexRepository extends Mock implements PokedexApi {}

void main() {
  group('PokedexRepository', () {
    late PokedexApi pokedexApi;
    late PokedexRepository pokedexRepository;
    setUp(() {
      pokedexApi = MockPokedexRepository();
      pokedexRepository = PokemonRepositoryImpl(pokedexApi: pokedexApi);
    });

    group('constructor', () {
      test('defaults to internal PokedexApi if none is provided', () {
        expect(PokemonRepositoryImpl.new, isNot(throwsA(isA<Exception>())));
      });
    });

    group('Get Pokemon List', () {
      test(
          'return PokemonResponse '
          'from PokedexApi.getPokemonList', () {
        const response = PokemonResponse(
          count: 0,
          next: '',
          previous: '',
          results: [],
        );
        when(() => pokedexApi.getPokemonList())
            .thenAnswer((_) async => response);

        expect(
          pokedexRepository.getPokemonList(),
          completion(equals(response)),
        );

        verify(() => pokedexApi.getPokemonList()).called(1);
      });

      test(
        'throws PokedexFailure '
        'if PokedexApi.getPokemonList fails',
        () async {
          when(pokedexApi.getPokemonList)
              .thenThrow(GetPokemonException('meesage'));

          expect(
            () => pokedexRepository.getPokemonList(),
            throwsA(isA<PokedexFailure>()),
          );
        },
      );
    });

    group('Get Pokemon Details', () {
      test(
        'Get Pokemon Details '
        'call PokedexApi.getPokemonDetails',
        () async {
          final rawData = fixture('pokemon_details.json');
          final data = jsonDecode(rawData) as Map<String, dynamic>;
          final response = PokemonDetailResponse.fromJson(data);
          when(() => pokedexApi.getPokemonDetails('pokemonName'))
              .thenAnswer((_) async => response);

          final request =
              await pokedexRepository.getPokemonDetails('pokemonName');
          expect(
            request,
            response,
          );

          verify(
            () => pokedexApi.getPokemonDetails('pokemonName'),
          ).called(1);
        },
      );

      test(
        'Get pokemon Details '
        ' throws PokedexFailure ',
        () {
          when(() => pokedexApi.getPokemonDetails('pokemonName'))
              .thenThrow(GetPokemonDetailsException('message'));

          expect(
            () => pokedexRepository.getPokemonDetails('pokemonName'),
            throwsA(isA<PokedexFailure>()),
          );
        },
      );
    });

    group('Get Pokemon List', () {
      test(
        'Get Pokemon List '
        'call PokedexApi.getPokemonList',
        () async {
          final rawData = fixture('pokemon_list.json');
          final data = jsonDecode(rawData) as Map<String, dynamic>;
          final response = PokemonResponse.fromJson(data);
          when(
            () => pokedexApi.getPokemonList(
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer((_) async => response);

          final request = await pokedexRepository.getPokemonList();
          expect(
            request,
            response,
          );

          verify(
            () => pokedexApi.getPokemonList(),
          ).called(1);
        },
      );

      test(
        'Get Pokemon List '
        ' throws PokedexFailure ',
        () {
          when(
            () => pokedexApi.getPokemonList(
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenThrow(GetPokemonException('messade'));

          expect(
            pokedexRepository.getPokemonList(),
            throwsA(isA<PokedexFailure>()),
          );
        },
      );
    });

    group('Pokedex Repository Failure', () {
      test('PokedexFailure', () {
        expect(PokedexFailure('error').toString(), 'error');
      });
    });
  });
}
