import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/core.dart';
import 'package:pokedex/core/models/pokemon_stats.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late Dio dio;
  late PokedexApi pokedexApi;
  group('Pokedex Api', () {
    setUp(() {
      dio = MockDio();
      pokedexApi = PokedexApiImpl(dio: dio);
    });

    group('Get pokemon details calls dio api', () {
      test('description', () {
        final pokemonType = PokemonType(name: '', url: '');
        final types = Types(slot: 0, type: pokemonType);
        final stats = Stat(url: '', name: PokemonStat.attack);
        final pokemonStats = PokemonStats(baseStat: 0, effort: 0, stat: stats);
        final response = PokemonDetailResponse(
          id: 0,
          name: '',
          stats: [pokemonStats],
          height: 0,
          weight: 0,
          types: [types],
          baseExperience: 0,
        );
        final requestOption = RequestOptions(baseUrl: any(named: 'baseUrl'));
        final dioResponse = Response(requestOptions: requestOption);
        when(() => dio.get(any())).thenAnswer((_) async => dioResponse);

        expect(
          () => pokedexApi.getPokemonDetails('pokemonName'),
          completion(equals(response)),
        );
      });
    });
  });
}
