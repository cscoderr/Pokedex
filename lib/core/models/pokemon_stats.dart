import 'package:flutter/foundation.dart';
import 'package:pokedex/core/core.dart';

@immutable
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonStats &&
          other.runtimeType == runtimeType &&
          other.baseStat == baseStat &&
          other.effort == effort &&
          other.stat == stat;

  @override
  int get hashCode => baseStat.hashCode ^ effort.hashCode ^ stat.hashCode;
}
