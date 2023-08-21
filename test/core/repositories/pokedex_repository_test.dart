import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/core/models/pokemon_stats.dart';

class MockPokedexRepository extends Mock implements PokedexApi {}

void main() {
  group('PokedexRepository', () {
    late PokedexApi pokedexApi;
    late PokedexRepository pokedexRepository;
    setUp(() {
      pokedexApi = MockPokedexRepository();
      pokedexRepository = PokemonRepositoryImpl(pokedexApi: pokedexApi);
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
          when(pokedexApi.getPokemonList).thenThrow(GetPokemonException);

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
          const pokemonType = PokemonType(name: '', url: '');
          const types = Types(slot: 0, type: pokemonType);
          const stats = Stat(url: '', name: PokemonStat.attack);
          const pokemonStats =
              PokemonStats(baseStat: 0, effort: 0, stat: stats);
          final response = PokemonDetailResponse(
            id: 0,
            name: '',
            stats: [pokemonStats],
            height: 0,
            weight: 0,
            types: [types],
            baseExperience: 0,
          );
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
              .thenThrow(GetPokemonDetailsException);

          expect(
            () => pokedexRepository.getPokemonDetails('pokemonName'),
            throwsA(isA<PokedexFailure>()),
          );
        },
      );
    });
  });
}
