import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';

final pokedexRepositoryProvider = Provider<PokedexRepository>((ref) {
  return PokemonRepositoryImpl();
});

abstract class PokedexRepository {
  Future<PokemonResponse> getPokemonList({int? offset, int? limit});
  Future<PokemonDetails> getPokemonDetails(String pokemonName);
}

class PokemonRepositoryImpl implements PokedexRepository {
  PokemonRepositoryImpl({PokedexApi? pokedexApi})
      : _pokedexApi = pokedexApi ?? PokedexApiImpl();

  final PokedexApi _pokedexApi;

  @override
  Future<PokemonResponse> getPokemonList({int? offset, int? limit}) {
    print('enter');
    return _pokedexApi.getPokemonList();
  }

  @override
  Future<PokemonDetails> getPokemonDetails(String pokemonName) {
    return _pokedexApi.getPokemonDetails(pokemonName);
  }
}
