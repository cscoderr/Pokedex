import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pokedex/core/core.dart';

abstract class PokedexApi {
  Future<PokemonResponse> getPokemonList({int? offset, int? limit});
  Future<PokemonDetails> getPokemonDetails(String pokemonName);
}

class PokedexApiImpl implements PokedexApi {
  PokedexApiImpl({Dio? dio})
      : _dio = dio ?? Dio()
          ..options.baseUrl = AppConstants.baseUrl;
  final Dio _dio;

  @override
  Future<PokemonDetails> getPokemonDetails(String pokemonName) async {
    try {
      final response = await _dio.get('/pokemon/$pokemonName');
      if (response.statusCode == HttpStatus.ok) {
        print(response.data['type']);
        return PokemonDetails.fromJson(response.data as Map<String, dynamic>);
      }
      throw Exception('error getting pokemon list');
    } on DioError catch (e) {
      print(e.message);
      throw Exception('error getting pokemon list');
    }
  }

  @override
  Future<PokemonResponse> getPokemonList({int? offset, int? limit}) async {
    try {
      print(limit);
      final response = await _dio.get('/pokemon?limit=$limit&offset=$offset');
      if (response.statusCode == HttpStatus.ok) {
        return PokemonResponse.fromJson(response.data as Map<String, dynamic>);
      }
      throw Exception('error getting pokemon list');
    } on DioError catch (e) {
      print(e.message);
      throw Exception('error getting pokemon list');
    }
  }
}
