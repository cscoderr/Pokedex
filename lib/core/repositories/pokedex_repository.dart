import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/core.dart';

final pokedexRepositoryProvider = Provider<PokedexRepository>((ref) {
  return PokemonRepositoryImpl();
});

abstract class PokedexRepository {
  Future<PokemonResponse> getPokemonList({int? offset, int? limit});
  Future<PokemonDetailResponse> getPokemonDetails(String pokemonName);
}

class PokedexFailure implements Exception {
  PokedexFailure(this.message);
  final String message;

  @override
  String toString() {
    return message;
  }
}

class PokemonRepositoryImpl implements PokedexRepository {
  PokemonRepositoryImpl({PokedexApi? pokedexApi})
      : _pokedexApi = pokedexApi ?? PokedexApiImpl();

  final PokedexApi _pokedexApi;

  @override
  Future<PokemonResponse> getPokemonList({int? offset, int? limit}) async {
    try {
      final response = await _pokedexApi.getPokemonList(
        offset: offset,
        limit: limit,
      );
      return response;
    } on GetPokemonException catch (e) {
      throw PokedexFailure(e.toString());
    } catch (e) {
      throw PokedexFailure(e.toString());
    }
  }

  @override
  Future<PokemonDetailResponse> getPokemonDetails(String pokemonName) async {
    try {
      final response = await _pokedexApi.getPokemonDetails(pokemonName);
      return response;
    } on GetPokemonDetailsException catch (e) {
      throw PokedexFailure(e.toString());
    } catch (e) {
      throw PokedexFailure(e.toString());
    }
  }
}
