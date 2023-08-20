import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/core.dart';

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
  });
}
