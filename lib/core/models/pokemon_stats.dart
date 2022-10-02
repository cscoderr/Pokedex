import 'package:pokedex/core/core.dart';

class PokemonStats {
  const PokemonStats({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory PokemonStats.fromJson(Map<String, dynamic> json) {
    return PokemonStats(
      baseStat: json['base_stat'] as int?,
      effort: json['effort'] as int?,
      stat: Stat.fromJson(json['stat'] as Map<String, dynamic>),
    );
  }

  final int? baseStat;
  final int? effort;
  final Stat? stat;
}
