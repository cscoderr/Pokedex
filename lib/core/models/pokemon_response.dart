import 'package:pokedex/core/models/pokemon.dart';

class PokemonResponse {
  const PokemonResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PokemonResponse.fromJson(Map<String, dynamic> json) =>
      PokemonResponse(
        count: json['count'] as int?,
        next: json['next'] as String?,
        previous: json['previous'] as String?,
        results: json['results'] != null
            ? (json['results'] as List)
                .map((e) => Pokemon.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
      );

  final int? count;
  final String? next;
  final String? previous;
  final List<Pokemon>? results;
}
