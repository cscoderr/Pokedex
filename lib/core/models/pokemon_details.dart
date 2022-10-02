import 'package:pokedex/core/core.dart';
import 'package:pokedex/core/models/pokemon_stats.dart';

class PokemonDetails {
  PokemonDetails({
    this.id,
    this.name,
    this.height,
    this.weight,
    this.baseExperience,
    this.types,
    this.stats,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) => PokemonDetails(
        id: json['id'] as int?,
        name: json['name'] as String?,
        height: json['height'] as int?,
        weight: json['weight'] as int?,
        baseExperience: json['base_experience'] as int,
        stats: json['stats'] != null
            ? List<PokemonStats>.from(
                (json['stats'] as List<dynamic>).map(
                    (e) => PokemonStats.fromJson(e as Map<String, dynamic>)),
              )
            : null,
        types: json['types'] != null
            ? (json['types'] as List)
                .map((e) => Types.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
      );

  final int? id;
  final String? name;
  final int? height;
  final int? weight;
  final int? baseExperience;
  final List<Types>? types;
  final List<PokemonStats>? stats;
}
