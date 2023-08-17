import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pokedex/core/core.dart';

class GetPokemonDetailsException implements Exception {
  GetPokemonDetailsException(this.message);
  final String message;

  @override
  String toString() {
    return message;
  }
}

class GetPokemonException implements Exception {
  GetPokemonException(this.message);
  final String message;

  @override
  String toString() {
    return message;
  }
}

abstract class PokedexApi {
  Future<PokemonResponse> getPokemonList({int? offset, int? limit});
  Future<PokemonDetailResponse> getPokemonDetails(String pokemonName);
}

class PokedexApiImpl implements PokedexApi {
  PokedexApiImpl({Dio? dio})
      : _dio = dio ?? Dio()
          ..options.baseUrl = AppConstants.baseUrl;
  final Dio _dio;

  @override
  Future<PokemonDetailResponse> getPokemonDetails(String pokemonName) async {
    try {
      final response = await _dio.get('/pokemon/$pokemonName');
      if (response.statusCode == HttpStatus.ok) {
        return PokemonDetailResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
      }
      throw GetPokemonDetailsException(
        'Unable to get pokemon details, Try again',
      );
    } on DioException {
      throw GetPokemonDetailsException(
        'Unable to get pokemon details, Try again',
      );
    }
  }

  @override
  Future<PokemonResponse> getPokemonList({int? offset, int? limit}) async {
    try {
      final response = await _dio.get('/pokemon?limit=$limit&offset=$offset');
      if (response.statusCode == HttpStatus.ok) {
        return PokemonResponse.fromJson(response.data as Map<String, dynamic>);
      }
      throw GetPokemonException('Unable to get pokemon, Try again');
    } on DioException {
      throw GetPokemonException('Unable to get pokemon, Try again');
    }
  }
}
