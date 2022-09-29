import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';

final pokedexRepositoryProvider = Provider<PokedexRepository>((ref) {
  return PokemonRepositoryImpl();
});

abstract class PokedexRepository {
  Future<PokemonResponse> getPokemonList();
  Future<void> getPokemonDetails(String pokemonName);
}

class PokemonRepositoryImpl implements PokedexRepository {
  PokemonRepositoryImpl({PokedexApi? pokedexApi})
      : _pokedexApi = pokedexApi ?? PokedexApiImpl();

  final PokedexApi _pokedexApi;

  @override
  Future<PokemonResponse> getPokemonList() {
    print('enter');
    return _pokedexApi.getPokemonList();
  }

  @override
  Future<void> getPokemonDetails(String pokemonName) {
    // TODO: implement getPokemonDetails
    throw UnimplementedError();
  }
}
